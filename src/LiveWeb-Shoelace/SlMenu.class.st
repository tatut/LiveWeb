Class {
	#name : #SlMenu,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlMenu >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlMenu >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]
