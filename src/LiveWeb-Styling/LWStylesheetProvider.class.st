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

{ #category : #initialization }
LWStylesheetProvider >> initialize [
	styles := Dictionary new.
]

{ #category : #accessing }
LWStylesheetProvider >> style: aStyleBlock [
	"Register a new style in this stylesheet.
	Answers with an associaciont #class->'generated class name' that can be directly used
	in HTML rendering as attribute."

	| sender cls |
	
	"determine caller name and its parameters"
	sender := thisContext sender.
	cls :=  String streamContents: [:out |
		out nextPutAll: sender method selector asString;
			 nextPutAll: sender arguments hash asString ].
		
	"render style, if we haven't done so already"
	(styles includes: cls) ifFalse: [
		| rendered |
		rendered := String streamContents: [ :out |
			aStyleBlock value: (LWStyle on: out) ].
		 styles at: cls put: rendered
	].

	^ cls
]

{ #category : #writing }
LWStylesheetProvider >> writeOn: out [
	"write this stylesheet to the out stream"
	styles keysAndValuesDo: [ :class :decl |
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
