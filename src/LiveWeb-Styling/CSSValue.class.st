Class {
	#name : #CSSValue,
	#superclass : #CSSExpr,
	#instVars : [
		'value',
		'unit'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #'as yet unclassified' }
CSSValue class >> of: value as: unit [
	^ self new 
		value: value unit: unit; yourself 
]

{ #category : #converting }
CSSValue >> asCSSPropertyValue [ 
	^ value asCSSPropertyValue, unit.
]

{ #category : #'as yet unclassified' }
CSSValue >> value: v unit: u [
	value ifNotNil: [ ^ Error new signal: 'already initialized' ].
	value := v.
	unit := u.
]
