Class {
	#name : #LWBulmaTile,
	#superclass : #LWContainer,
	#instVars : [
		'styles'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #'as yet unclassified' }
LWBulmaTile >> beAncestor [ 
 styles add: 'is-ancestor'
]

{ #category : #'as yet unclassified' }
LWBulmaTile >> beChild [
 styles add: 'is-child'
]

{ #category : #'as yet unclassified' }
LWBulmaTile >> beVertical [
 styles add: 'is-vertical'
]

{ #category : #initialization }
LWBulmaTile >> initialize [
 super initialize.
 styles := #('tile') asOrderedCollection.
]

{ #category : #rendering }
LWBulmaTile >> renderOn: h [
	h div: { #class -> (' ' join: styles) } with: [ self renderChildren: h ]
]

{ #category : #'as yet unclassified' }
LWBulmaTile >> size: size [ 
 self assert: [ size >= 1 & size <= 12 ].
 styles add: ('is-{1}' format: { size })
]

{ #category : #accessing }
LWBulmaTile >> style: style [
	styles add: style.
	
]
