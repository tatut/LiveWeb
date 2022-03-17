Class {
	#name : #LWTemplateHTMLRenderer,
	#superclass : #Object,
	#instVars : [
		'target',
		'parent'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'reflective operations' }
LWTemplateHTMLRenderer >> doesNotUnderstand: aMessage [
	aMessage sendTo: target
]

{ #category : #accessing }
LWTemplateHTMLRenderer >> parent: anLWTemplate [
	parent := anLWTemplate 
]

{ #category : #accessing }
LWTemplateHTMLRenderer >> target: anHTMLRenderer [
	target := anHTMLRenderer 
]

{ #category : #'as yet unclassified' }
LWTemplateHTMLRenderer >> templateSlot: aSlotContentBlock [
	"Render a dynamic slot in the template. The content for the slot is accessed
	with the given block when using the template to render."
	| name |
	name := parent addSlot: aSlotContentBlock.
	target slot: { #name -> name }.
]
