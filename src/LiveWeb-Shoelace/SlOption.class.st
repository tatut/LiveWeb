Class {
	#name : #SlOption,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlOption class >> elementAttributes [ 
^#(
 (value string)
 (disabled boolean)
)
]

{ #category : #'as yet unclassified' }
SlOption class >> elementSlots [ 
 ^#(prefix suffix)
]

{ #category : #'as yet unclassified' }
SlOption class >> option: aLabel value: aValue [
 "Construct a new option with label and value."
 ^ self new 
	add: aLabel;
	value: aValue;
	yourself.	
]

{ #category : #'as yet unclassified' }
SlOption >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlOption >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlOption >> prefix [
		^ self slotAt: 'prefix'.
]

{ #category : #'as yet unclassified' }
SlOption >> prefix: aComponentOrString [
		self slotAt: 'prefix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlOption >> suffix [
		^ self slotAt: 'suffix'.
]

{ #category : #'as yet unclassified' }
SlOption >> suffix: aComponentOrString [
		self slotAt: 'suffix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlOption >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlOption >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]
