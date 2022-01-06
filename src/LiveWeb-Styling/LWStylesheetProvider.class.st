"
I allow subclasses to build new styles dynamically and cache the CSS style sheet.

The style sheet can be sent on each page and any new dynamically added styles
will be sent through the WebSocket so that any new styles will be available without
doing a page reload.

Subclasses should provide style methods that register CSS with the.

For example:

>>> flex: dir background: col
>>>   ^ self style: [:s | s display: 'flex'; flexDirection: dir; background: col ]

This will register a new CSS style and generate a class name for it. 
The method will answer with an association #class->'generated class name'

Note that the methods should be *pure* so that they only use the parameters and 
not any internal state of the object. The class name is generated solely based 
on the method selector and a hash of the arguments.
"
Class {
	#name : #LWStylesheetProvider,
	#superclass : #Object,
	#instVars : [
		'styles'
	],
	#category : #'LiveWeb-Styling'
}

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
]

{ #category : #accessing }
LWStylesheetProvider >> registerClass: cls with: aStyleBlock [
   | b |
	(styles includes: cls) ifTrue: [ ^ self ].
	b := LWStyleBuilder new.
	aStyleBlock value: b.
	styles 
		at: cls
		put: (String streamContents: [ :out | b writeOn: out]) 
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

	^ cls
]

{ #category : #accessing }
LWStylesheetProvider >> style: aStyleBlock named: namePrefix [
	"Register a new style in this stylesheet with overridden name prefix"
	| cls |	
	cls := self generateClassName: namePrefix with: thisContext sender arguments.
	self registerClass: cls with: aStyleBlock.
	^ cls
]

{ #category : #writing }
LWStylesheetProvider >> writeOn: out [
	"write this stylesheet to the out stream"
	styles keysAndValuesDo: [ :class :decl |
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
]
