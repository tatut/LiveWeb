Class {
	#name : #SlSplitPanel,
	#superclass : #SlElement,
	#instVars : [
		'slot'
	],
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlSplitPanel class >> elementAttributes [ 
 ^#(
 ( position number )
 ( vertical boolean )
 ( disabled boolean )
 ( primary (start end) )
 ( snap string )
 ( snapThreshold number )
)
]

{ #category : #'as yet unclassified' }
SlSplitPanel class >> elementSlots [ 
 ^ #( start end divider )

]

{ #category : #'as yet unclassified' }
SlSplitPanel >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> divider [
		^ self slotAt: 'divider'.
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> divider: aComponentOrString [
		self slotAt: 'divider' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> end [
		^ self slotAt: 'end'.
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> end: aComponentOrString [
		self slotAt: 'end' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> position [
		^ self attrAt: 'position'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> position: newValue [
		self assert: newValue isNumber.
		self attrAt: 'position' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> primary [
		^ self attrAt: 'primary'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> primary: newValue [
		self assert: ( #( 'start' 'end' ) includes: newValue).
		self attrAt: 'primary' update: [ newValue ]
]

{ #category : #rendering }
SlSplitPanel >> renderOn: h [
	slot
		ifNil: [  super renderOn: h ]
	 	ifNotNil: [ h div: { #style->'display: inline-block;'. #slot -> slot } with: [  super renderOn: h ] ]

]

{ #category : #'as yet unclassified' }
SlSplitPanel >> slot: slotName [
	"Set the slot name if this panel is a slot in a parent panel.
	 An inline-block div will be rendered around the element."
	slot := slotName.
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> snap [
		^ self attrAt: 'snap'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> snap: newValue [
		self assert: newValue isString.
		self attrAt: 'snap' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> snapThreshold [
		^ self attrAt: 'snapThreshold'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> snapThreshold: newValue [
		self assert: newValue isNumber.
		self attrAt: 'snapThreshold' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> start [
		^ self slotAt: 'start'.
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> start: aComponentOrString [
		self slotAt: 'start' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> vertical [
		^ self attrAt: 'vertical'
]

{ #category : #'as yet unclassified' }
SlSplitPanel >> vertical: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'vertical' update: [ newValue ]
]
