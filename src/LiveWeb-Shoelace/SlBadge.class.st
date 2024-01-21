Class {
	#name : #SlBadge,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlBadge class >> badgeVariant: variant with: text [
 ^ self new 
  variant: variant;
  add: text;
  yourself
]

{ #category : #'as yet unclassified' }
SlBadge class >> badgesExample [  
 <lwExample: 'all badge variants'>
 ^ LWContainer with: {  
   self primary: 'primary'.
   self success: 'success'.
	(self neutral: 'neutral pill') pill: true.
	self warning: 'warning'.
	(self danger: 'danger pulse') pulse: true }
]

{ #category : #'as yet unclassified' }
SlBadge class >> danger: content [ 
 ^ self badgeVariant: 'danger' with: content
]

{ #category : #'as yet unclassified' }
SlBadge class >> elementAttributes [ 
 ^#(
 (variant (primary success neutral warning danger))
 (pill boolean)
 (pulse boolean)
)
]

{ #category : #'as yet unclassified' }
SlBadge class >> neutral: content [ 
 ^ self badgeVariant: 'neutral' with: content
]

{ #category : #'as yet unclassified' }
SlBadge class >> primary: content [ 
 ^ self badgeVariant: 'primary' with: content
]

{ #category : #'as yet unclassified' }
SlBadge class >> success: content [ 
 ^ self badgeVariant: 'success' with: content
]

{ #category : #'as yet unclassified' }
SlBadge class >> warning: content [ 
 ^ self badgeVariant: 'warning' with: content
]

{ #category : #'as yet unclassified' }
SlBadge >> pill [
		^ self attrAt: 'pill'
]

{ #category : #'as yet unclassified' }
SlBadge >> pill: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pill' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlBadge >> pulse [
		^ self attrAt: 'pulse'
]

{ #category : #'as yet unclassified' }
SlBadge >> pulse: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pulse' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlBadge >> variant [
		^ self attrAt: 'variant'
]

{ #category : #'as yet unclassified' }
SlBadge >> variant: newValue [
		self assert: ( #( 'primary' 'success' 'neutral' 'warning' 'danger' ) includes: newValue).
		self attrAt: 'variant' update: [ newValue ]
]
