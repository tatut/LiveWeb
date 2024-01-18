Class {
	#name : #SlAlert,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlAlert >> default [
		^ self slotAt: 'default'.
]

{ #category : #'as yet unclassified' }
SlAlert >> default: aComponent [
		self slotAt: 'default' put: aComponent.
]

{ #category : #'as yet unclassified' }
SlAlert >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlAlert >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]
