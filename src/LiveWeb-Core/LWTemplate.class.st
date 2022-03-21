"
I render an HTML <template> element that can be used later
to render it on the client side.

For example a result set where all the results share the 
same template and are dynamically rendered after the initial
render of the page.

This can reduce the amount of data sent to the client. The template
is only sent once during initial rendering of the page. When 
rendering using the template, only the raw data for the slots
needs to be sent.

Subclasses must override #renderTemplate: to render the 
actual template markup and call #slot: during render to register
the dynamic slots for the template and the code (block) used
to access the data.
"
Class {
	#name : #LWTemplate,
	#superclass : #LWComponent,
	#instVars : [
		'slots',
		'template'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #adding }
LWTemplate >> addSlot: aSlotContentBlock [ 
   | existingIndex |
	slots ifNil: [ slots := OrderedCollection new ].
	existingIndex := slots indexOf: aSlotContentBlock.
	existingIndex isZero 
	ifTrue: [ 
	  slots add: aSlotContentBlock.
	  ^ (slots size - 1) asString ]
   ifFalse: [ 
	  ^ (existingIndex - 1) asString ]
]

{ #category : #rendering }
LWTemplate >> renderItems: aCollection to: anElementId [ 
	"Render (on the client side) the given items to the given HTML element identified by id.
	The content of the element will be replaced with the rendered content."
	self send: 'T' with: { 
		anElementId. 
		aCollection 
			collect: [ :item |
				slots collect: [ :s | s value: item ] as: Array ] as: Array }
]

{ #category : #rendering }
LWTemplate >> renderOn: h [
	h template: [ 
		template value: (LWTemplateHTMLRenderer new 
			parent: self;
			out: h out;
			yourself)
	]
]

{ #category : #rendering }
LWTemplate >> renderTemplate: h [
	self subclassResponsibility 
]

{ #category : #accessing }
LWTemplate >> template: aTemplateRenderingBlock [
	"Set the block to render the template, received a special HTMLRenderer 
	which supports adding slots via #templateSlot: "
	template := aTemplateRenderingBlock 
]
