Class {
	#name : #LWTemplateHTMLRenderer,
	#superclass : #HTMLRenderer,
	#instVars : [
		'parent'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWTemplateHTMLRenderer >> parent: anLWTemplate [
	parent := anLWTemplate 
]

{ #category : #'as yet unclassified' }
LWTemplateHTMLRenderer >> templateAttr: attributeName with: aSlotContentBlock [
	"Render a dynamic attribute in the template. The content for the slot is accessed
	with the given block when using the template to render."
	| name |
	name := '_lw_slot:', (parent addSlot: aSlotContentBlock).
	^ attributeName -> name .
]

{ #category : #'as yet unclassified' }
LWTemplateHTMLRenderer >> templateSlot: aSlotContentBlock [
	"Render a dynamic slot in the template. The content for the slot is accessed
	with the given block when using the template to render."
	| name |
	name := parent addSlot: aSlotContentBlock.
	self slot: { #name -> name }.
]
