Class {
	#name : #SlMenu,
	#superclass : #SlElement,
	#instVars : [
		'dynamicItems'
	],
	#category : #'LiveWeb-Shoelace'
}

{ #category : #accessing }
SlMenu >> dynamicItems: aBlock [
	"Set a block to render dynamic menu items that are not children."
	dynamicItems := aBlock.
]

{ #category : #rendering }
SlMenu >> renderContent: h [
	super renderContent: h.
	dynamicItems ifNotNil: [ dynamicItems value: h ]
]

{ #category : #'as yet unclassified' }
SlMenu >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlMenu >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]
