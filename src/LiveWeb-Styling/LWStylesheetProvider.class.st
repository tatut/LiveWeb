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

	| sender name params |
	
	"determine caller name and its parameters"
	sender := thisContext sender.
	^ String streamContents: [:out |
		out nextPutAll: sender method selector asString;
		    nextPut: $-;
			 nextPutAll: sender arguments hash asString ]
]
