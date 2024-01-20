Class {
	#name : #SlTag,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlTag class >> danger: content [ 
 ^ self new variant: 'danger'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag class >> elementAttributes [ 
^#(
 (variant (primary success neutral warning danger text))
 (size (small medium large))
 (pill boolean)
 (removable boolean)
)
]

{ #category : #'as yet unclassified' }
SlTag class >> neutral: content [ 
 ^ self new variant: 'neutral'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag class >> primary: content [ 
 ^ self new variant: 'primary'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag class >> success: content [ 
 ^ self new variant: 'success'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag class >> text: content [ 
 ^ self new variant: 'text'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag class >> warning: content [ 
 ^ self new variant: 'warning'; add: content; yourself

]

{ #category : #'as yet unclassified' }
SlTag >> pill [
		^ self attrAt: 'pill'
]

{ #category : #'as yet unclassified' }
SlTag >> pill: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pill' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlTag >> removable [
		^ self attrAt: 'removable'
]

{ #category : #'as yet unclassified' }
SlTag >> removable: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'removable' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlTag >> size [
		^ self attrAt: 'size'
]

{ #category : #'as yet unclassified' }
SlTag >> size: newValue [
		self assert: ( #( 'small' 'medium' 'large' ) includes: newValue).
		self attrAt: 'size' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlTag >> variant [
		^ self attrAt: 'variant'
]

{ #category : #'as yet unclassified' }
SlTag >> variant: newValue [
		self assert: ( #( 'primary' 'success' 'neutral' 'warning' 'danger' 'text' ) includes: newValue).
		self attrAt: 'variant' update: [ newValue ]
]
