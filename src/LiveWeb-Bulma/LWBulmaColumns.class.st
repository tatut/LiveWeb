"
I am a Bulma columns layout, add components to me using the methods
like #oneFifth: etc or a size directly using #add:sized:.

See https://bulma.io/documentation/columns/sizes/

"
Class {
	#name : #LWBulmaColumns,
	#superclass : #LWComponent,
	#instVars : [
		'columns'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #'as yet unclassified' }
LWBulmaColumns >> add: aComponent sized: size [
 "Add any Bulma size definition, like 12 column "
 columns add: aComponent -> ('is-', size asString)
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> auto: aComponent [ 
	"Add an auto-sized column component"
	columns add: aComponent -> ''.
]

{ #category : #accessing }
LWBulmaColumns >> children [ 
 ^ ReadStream on: (columns collect: #key)

]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> fourFifths: aComponent [
	"Add component that takes four fifths of space"
  columns add: aComponent -> 'is-four-fifths'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> full: aComponent [ 
 "Add component that takes all space"
 columns add: aComponent -> 'is-full'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> half: aComponent [ 
 columns add: aComponent -> 'is-half'
]

{ #category : #initialization }
LWBulmaColumns >> initialize [ 
 super initialize.
 columns := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> oneFifth: aComponent [
	"Add component that takes one fifth of space"
  columns add: aComponent -> 'is-one-fifth'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> oneQuarter: aComponent [ 
 columns add: aComponent -> 'is-one-quarter'
]

{ #category : #rendering }
LWBulmaColumns >> renderOn: h [
 h div: { #class -> 'columns' } with: [ 
	columns do: [ :c |
		h div: { #class -> ('column {1}' format: {c value}) } with: [ c key render: h ]
	]
 ]
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> threeFifths: aComponent [
	"Add component that takes four fifths of space"
  columns add: aComponent -> 'is-three-fifths'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> threeQuarters: aComponent [ 
 columns add: aComponent -> 'is-three-quarters'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> twoFifths: aComponent [
	"Add component that takes four fifths of space"
  columns add: aComponent -> 'is-two-fifths'
]

{ #category : #'as yet unclassified' }
LWBulmaColumns >> twoThirds: aComponent [ 
 columns add: aComponent -> 'is-two-thirds'
]
