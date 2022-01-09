"
I am a component that renders a single block as a component.
This is convenient to simply swap some content by setting the block.

The block being rendered must output one root element which will consume
the component id.

If the block is nil, a placeholder script will be output.
"
Class {
	#name : #LWBlockContainer,
	#superclass : #LWComponent,
	#instVars : [
		'block'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWBlockContainer >> block: aBlock [
	block := aBlock.
	self changed.
]

{ #category : #rendering }
LWBlockContainer >> renderOn: h [
	block
	 ifNil: [ h script: { #type -> 'liveweb/placeholder' } with: '' ]
	 ifNotNil: [ block value: h ].
]
