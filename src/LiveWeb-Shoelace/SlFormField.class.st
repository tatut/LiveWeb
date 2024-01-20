"
I am the base class for form field Shoelace elements. 
I provide accessors for the common properties.

"
Class {
	#name : #SlFormField,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlFormField class >> elementAttributes [ 
 ^ #( 
 (required boolean)
 (size (small medium large))
 (name string)
 (value string)
 (disabled boolean)
), super elementAttributes 
]

{ #category : #'as yet unclassified' }
SlFormField class >> elementProperties [ 
 ^ #()

]

{ #category : #'as yet unclassified' }
SlFormField >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlFormField >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlFormField >> name [
		^ self attrAt: 'name'
]

{ #category : #'as yet unclassified' }
SlFormField >> name: newValue [
		self assert: newValue isString.
		self attrAt: 'name' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlFormField >> required [
		^ self attrAt: 'required'
]

{ #category : #'as yet unclassified' }
SlFormField >> required: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'required' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlFormField >> size [
		^ self attrAt: 'size'
]

{ #category : #'as yet unclassified' }
SlFormField >> size: newValue [
		self assert: ( #( 'small' 'medium' 'large' ) includes: newValue).
		self attrAt: 'size' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlFormField >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlFormField >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlFormField >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlFormField >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]
