Class {
	#name : #SlAlert,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlAlert class >> elementAttributes [ 
 ^ #( 
 (open boolean)
 (closable boolean)
 (variant (primary success neutral warning danger))
 (duration number)
), super elementAttributes 

]

{ #category : #'as yet unclassified' }
SlAlert class >> elementSlots [  
 ^ #(icon)
]

{ #category : #'as yet unclassified' }
SlAlert >> closable [
		^ self attrAt: 'closable'
]

{ #category : #'as yet unclassified' }
SlAlert >> closable: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'closable' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> default [
		^ self slotAt: 'default'.
]

{ #category : #'as yet unclassified' }
SlAlert >> default: aComponentOrString [
		self slotAt: 'default' put: (aComponentOrString isString 
		  ifTrue: [ LWBlockContainer new block: [ :h | h span: aComponentOrString ] ]
		  ifFalse: [ aComponentOrString ]).
]

{ #category : #'as yet unclassified' }
SlAlert >> duration [
		^ self attrAt: 'duration'
]

{ #category : #'as yet unclassified' }
SlAlert >> duration: newValue [
		self assert: newValue isNumber.
		self attrAt: 'duration' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> icon [
		^ self slotAt: 'icon'.
]

{ #category : #'as yet unclassified' }
SlAlert >> icon: aComponentOrString [
		self slotAt: 'icon' put: (aComponentOrString isString 
		  ifTrue: [ LWBlockContainer new block: [ :h | h span: aComponentOrString ] ]
		  ifFalse: [ aComponentOrString ]).
]

{ #category : #'as yet unclassified' }
SlAlert >> open [
		^ self attrAt: 'open'
]

{ #category : #'as yet unclassified' }
SlAlert >> open: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'open' update: [ newValue ]
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

{ #category : #'as yet unclassified' }
SlAlert >> variant [
		^ self attrAt: 'variant'
]

{ #category : #'as yet unclassified' }
SlAlert >> variant: newValue [
		self assert: ( #( 'primary' 'success' 'neutral' 'warning' 'danger' ) includes: newValue).
		self attrAt: 'variant' update: [ newValue ]
]
