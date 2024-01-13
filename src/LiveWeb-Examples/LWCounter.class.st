Class {
	#name : #LWCounter,
	#superclass : #LWComponent,
	#instVars : [
		'counter'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #examples }
LWCounter class >> example42 [ 
 <lwExample: 'Counter with value 42'>
 ^ self new counter: 42.
]

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
	h div: { #class->'box counterComponent' } with: [ 
		h button: { #class -> 'button is-small inc'. #onclick -> [ self counter: counter + 1 ] } with: '+'.
		h div: { #class -> 'counter' } with: counter.
		h button: { #class -> 'button is-small dec'. #onclick -> [ self counter: counter - 1 ] } with: '-'
	]
]
