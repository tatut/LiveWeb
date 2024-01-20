Class {
	#name : #SlMenuItem,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlMenuItem class >> elementAttributes [ 
 ^ #(
 (type (normal checkbox))
 (checked boolean)
 (value string)
 (disabled boolean)
)
]

{ #category : #'as yet unclassified' }
SlMenuItem class >> elementSlots [ 
 ^ #( prefix suffix submenu )
]

{ #category : #'as yet unclassified' }
SlMenuItem >> checked [
		^ self attrAt: 'checked'
]

{ #category : #'as yet unclassified' }
SlMenuItem >> checked: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'checked' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlMenuItem >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlMenuItem >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #accessing }
SlMenuItem >> label: aLabel [
 self add: aLabel.
]

{ #category : #'as yet unclassified' }
SlMenuItem >> prefix [
		^ self slotAt: 'prefix'.
]

{ #category : #'as yet unclassified' }
SlMenuItem >> prefix: aComponentOrString [
		self slotAt: 'prefix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlMenuItem >> submenu [
		^ self slotAt: 'submenu'.
]

{ #category : #'as yet unclassified' }
SlMenuItem >> submenu: aComponentOrString [
		self slotAt: 'submenu' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlMenuItem >> suffix [
		^ self slotAt: 'suffix'.
]

{ #category : #'as yet unclassified' }
SlMenuItem >> suffix: aComponentOrString [
		self slotAt: 'suffix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlMenuItem >> type [
		^ self attrAt: 'type'
]

{ #category : #'as yet unclassified' }
SlMenuItem >> type: newValue [
		self assert: ( #( 'normal' 'checkbox' ) includes: newValue).
		self attrAt: 'type' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlMenuItem >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlMenuItem >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]
