Class {
	#name : #SlSelect,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlSelect class >> elementAttributes [ 
^#(
 (name string)
 (value string)
 (defaultValue string)
 (size (small medium large))
 (placeholder string)
 (multiple boolean)
 ('max-options-visible' number)
 (disabled boolean)
 (clearable boolean)
 (open boolean)
 (hoist boolean)
 (filled boolean)
 (pill boolean)
 (placement (top bottom))
 (form string)
 (required boolean) 
)
]

{ #category : #'as yet unclassified' }
SlSelect class >> elementSlots [ 
 ^#(label prefix 'clear-icon' 'expand-icon' 'help-text')
]

{ #category : #'as yet unclassified' }
SlSelect class >> simpleSelectExample [
	<lwExample: 'Simple select with predefined options'>
	| selected |
	^ LWContainer with: { self new
		  placeholder: 'Select your favorite programming language';
		  on: SlChangeEvent do: [ :e | selected child: e value asLWComponent  ];
		  options: { 'Smalltalk' -> 'st'.
						 'Clojure' -> 'clj'.
						 'Prolog' -> 'pl'.
						 'Erlang' -> 'erl' };
		  yourself.
		selected := LWSingleContainer new. }
]

{ #category : #'as yet unclassified' }
SlSelect >> clearIcon [
		^ self slotAt: 'clear-icon'.
]

{ #category : #'as yet unclassified' }
SlSelect >> clearIcon: aComponentOrString [
		self slotAt: 'clear-icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSelect >> clearable [
		^ self attrAt: 'clearable'
]

{ #category : #'as yet unclassified' }
SlSelect >> clearable: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'clearable' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> defaultValue [
		^ self attrAt: 'defaultValue'
]

{ #category : #'as yet unclassified' }
SlSelect >> defaultValue: newValue [
		self assert: newValue isString.
		self attrAt: 'defaultValue' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlSelect >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> expandIcon [
		^ self slotAt: 'expand-icon'.
]

{ #category : #'as yet unclassified' }
SlSelect >> expandIcon: aComponentOrString [
		self slotAt: 'expand-icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSelect >> filled [
		^ self attrAt: 'filled'
]

{ #category : #'as yet unclassified' }
SlSelect >> filled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'filled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> form [
		^ self attrAt: 'form'
]

{ #category : #'as yet unclassified' }
SlSelect >> form: newValue [
		self assert: newValue isString.
		self attrAt: 'form' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> helpText [
		^ self slotAt: 'help-text'.
]

{ #category : #'as yet unclassified' }
SlSelect >> helpText: aComponentOrString [
		self slotAt: 'help-text' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSelect >> hoist [
		^ self attrAt: 'hoist'
]

{ #category : #'as yet unclassified' }
SlSelect >> hoist: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'hoist' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> label [
		^ self slotAt: 'label'.
]

{ #category : #'as yet unclassified' }
SlSelect >> label: aComponentOrString [
		self slotAt: 'label' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSelect >> maxOptionsVisible [
		^ self attrAt: 'max-options-visible'
]

{ #category : #'as yet unclassified' }
SlSelect >> maxOptionsVisible: newValue [
		self assert: newValue isNumber.
		self attrAt: 'max-options-visible' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> multiple [
		^ self attrAt: 'multiple'
]

{ #category : #'as yet unclassified' }
SlSelect >> multiple: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'multiple' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> name [
		^ self attrAt: 'name'
]

{ #category : #'as yet unclassified' }
SlSelect >> name: newValue [
		self assert: newValue isString.
		self attrAt: 'name' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> open [
		^ self attrAt: 'open'
]

{ #category : #'as yet unclassified' }
SlSelect >> open: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'open' update: [ newValue ]
]

{ #category : #accessing }
SlSelect >> options: labelsAndValues [ 
	"Add options from a dictionary or array of associations.
	The key is the label and value is the value.
	Value should not contain spaces."
	labelsAndValues asDictionary keysAndValuesDo: [ :label :value |
		self add: (SlOption option: label value: value) ]
]

{ #category : #'as yet unclassified' }
SlSelect >> pill [
		^ self attrAt: 'pill'
]

{ #category : #'as yet unclassified' }
SlSelect >> pill: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pill' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> placeholder [
		^ self attrAt: 'placeholder'
]

{ #category : #'as yet unclassified' }
SlSelect >> placeholder: newValue [
		self assert: newValue isString.
		self attrAt: 'placeholder' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> placement [
		^ self attrAt: 'placement'
]

{ #category : #'as yet unclassified' }
SlSelect >> placement: newValue [
		self assert: ( #( 'top' 'bottom' ) includes: newValue).
		self attrAt: 'placement' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> prefix [
		^ self slotAt: 'prefix'.
]

{ #category : #'as yet unclassified' }
SlSelect >> prefix: aComponentOrString [
		self slotAt: 'prefix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSelect >> required [
		^ self attrAt: 'required'
]

{ #category : #'as yet unclassified' }
SlSelect >> required: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'required' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> size [
		^ self attrAt: 'size'
]

{ #category : #'as yet unclassified' }
SlSelect >> size: newValue [
		self assert: ( #( 'small' 'medium' 'large' ) includes: newValue).
		self attrAt: 'size' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlSelect >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSelect >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlSelect >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]
