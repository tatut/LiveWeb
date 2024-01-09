Class {
	#name : #LWCounter,
	#superclass : #LWComponent,
	#instVars : [
		'counter'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWCounter >> counter: newCounterValue [
	counter := newCounterValue.
	self changed.
]

{ #category : #initialization }
LWCounter >> initialize [ 
	super initialize.
	counter := 0.

]

{ #category : #rendering }
LWCounter >> renderOn: h [
	h div: { #class->'counterComponent' } with: [ 
		h button: { #class -> 'inc'. #onclick -> [ self counter: counter + 1 ] } with: '+'.
		h div: { #class -> 'counter' } with: counter.
		h button: { #class -> 'dec'. #onclick -> [ self counter: counter - 1 ] } with: '-'
	]
]
