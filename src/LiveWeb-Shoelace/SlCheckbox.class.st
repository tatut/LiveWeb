Class {
	#name : #SlCheckbox,
	#superclass : #SlFormField,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlCheckbox class >> elementAttributes [ 
  ^ #(
 (checked boolean)
 (indeterminate boolean)
 (defaultChecked boolean)
), super elementAttributes 
]

{ #category : #'as yet unclassified' }
SlCheckbox >> checked [
		^ self attrAt: 'checked'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> checked: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'checked' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> default [
		^ self slotAt: 'default'.
]

{ #category : #'as yet unclassified' }
SlCheckbox >> default: aComponent [
		self slotAt: 'default' put: aComponent.
]

{ #category : #'as yet unclassified' }
SlCheckbox >> defaultChecked [
		^ self attrAt: 'defaultChecked'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> defaultChecked: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'defaultChecked' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> indeterminate [
		^ self attrAt: 'indeterminate'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> indeterminate: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'indeterminate' update: [ newValue ]
]

{ #category : #accessing }
SlCheckbox >> label: textOrComponent [
  self default: (textOrComponent isString 
	ifTrue: [ LWBlockContainer new block: [ :h | h span: textOrComponent ] ]
	ifFalse: [ textOrComponent ])

]

{ #category : #'as yet unclassified' }
SlCheckbox >> name [
		^ self attrAt: 'name'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> name: newValue [
		self assert: newValue isString.
		self attrAt: 'name' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> required [
		^ self attrAt: 'required'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> required: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'required' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> size [
		^ self attrAt: 'size'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> size: newValue [
		self assert: ( #( 'small' 'medium' 'large' ) includes: newValue).
		self attrAt: 'size' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlCheckbox >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]

{ #category : #accessing }
SlCheckbox >> tag [ 
 ^ 'sl-checkbox'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlCheckbox >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]
