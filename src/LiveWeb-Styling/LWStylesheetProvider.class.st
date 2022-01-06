"
I allow subclasses to build new styles dynamically and cache the CSS style sheet.

The style sheet can be sent on each page and any new dynamically added styles
will be sent through the WebSocket so that any new styles will be available without
doing a page reload (see LWStylesheetComponent).

Subclasses should provide style methods that register CSS with the.

For example:

>>> flex: dir background: col
>>>   ^ self style: [:s | s display: 'flex'; flexDirection: dir; background: col ]

This will register a new CSS style and generate a class name for it. 
The method will answer with an association #class->'generated class name' that
can be directly used in HTML rendering of components.

Note that the methods should be *pure* so that they only use the parameters and 
not any internal state of the object. The class name is generated solely based 
on the method selector and a hash of the arguments.
"
Class {
	#name : #LWStylesheetProvider,
	#superclass : #Object,
	#instVars : [
		'styles',
		'listeners'
	],
	#classVars : [
		'providers'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #'as yet unclassified' }
LWStylesheetProvider class >> clearProviders [
	providers := Dictionary new.
]

{ #category : #accessing }
LWStylesheetProvider class >> provider: class [
	"Get a singleton provider of the given class."
	providers ifNil: [ providers := Dictionary new ].
	^ providers at: class ifAbsentPut: [ class new ].
]

{ #category : #adding }
LWStylesheetProvider >> addStyleAddedListener: listener [ 
	"add listener for added styles"
	listeners add: listener.
	
]

{ #category : #'as yet unclassified' }
LWStylesheetProvider >> generateClassName: namePrefix with: arguments [
	^ arguments isEmpty 
		ifTrue: [ namePrefix ] 
		ifFalse: [ String streamContents: [:out |
			out nextPutAll: namePrefix;
				 nextPutAll: arguments hash asString ] ].

]

{ #category : #initialization }
LWStylesheetProvider >> initialize [
	styles := Dictionary new.
	listeners := IdentitySet new.
]

{ #category : #accessing }
LWStylesheetProvider >> registerClass: cls with: aStyleBlock [
   | b decl css |
	(styles includesKey: cls) ifTrue: [ ^ self ].
	b := LWStyleBuilder new.
	aStyleBlock value: b.
	decl := String streamContents: [ :out | b writeOn: out].
	styles 
		at: cls
		put: decl. 
		
	"Send new CSS declarations in the background to any listening pages"
	[ css := String streamContents: [ :out | self writeCSS: cls decl: decl on: out ].
	  listeners do: [ :l | l onStyleAdded: css ] ] fork
]

{ #category : #adding }
LWStylesheetProvider >> removeStyleAddedListener: listener [ 
	"add listener for added styles"
	listeners remove: listener.
	
]

{ #category : #accessing }
LWStylesheetProvider >> style: aStyleBlock [
	"Register a new style in this stylesheet.
	Answers with an associaciont #class->'generated class name' that can be directly used
	in HTML rendering as attribute."

	| sender cls |
	
	"determine caller name and its parameters"
	sender := thisContext sender.
	cls :=  self generateClassName: sender method selector asString
		 with: sender arguments.
		
	self registerClass: cls with: aStyleBlock.

	^ #class->cls
]

{ #category : #accessing }
LWStylesheetProvider >> style: aStyleBlock named: namePrefix [
	"Register a new style in this stylesheet with overridden name prefix"
	| cls |	
	cls := self generateClassName: namePrefix with: thisContext sender arguments.
	self registerClass: cls with: aStyleBlock.
	^ #class->cls
]

{ #category : #writing }
LWStylesheetProvider >> writeCSS: class decl: decl on: out [ 
	out nextPut: $..
		(class indexOf: $:) > 0 
			ifTrue: [ | split |
				split := class splitOn: ':'.
				split allButLastDo: [ :part | out nextPutAll: part; nextPutAll: '\:' ].
				out nextPutAll: split last ]
			ifFalse: [ out nextPutAll: class ].
		out nextPutAll: ' { '; 
		    nextPutAll: decl;
		    nextPutAll: '}'; 
		    nextPut: Character lf.
]

{ #category : #writing }
LWStylesheetProvider >> writeOn: out [
	"write this stylesheet to the out stream"
	styles keysAndValuesDo: [ :class :decl |
		self writeCSS: class decl: decl on: out.
   ]
]
