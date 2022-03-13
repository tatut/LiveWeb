"
I am a CSS leaf value.
"
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

{ #category : #comparing }
CSSValue >> = anObject [
	"Answer whether the receiver and anObject represent the same object."
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ value = anObject value1 and: [ unit = anObject unit ]
]

{ #category : #converting }
CSSValue >> asCSSPropertyValue [ 
	^ value asCSSPropertyValue, unit.
]

{ #category : #comparing }
CSSValue >> hash [
	"Answer an integer value that is related to the identity of the receiver."
	^ value hash bitXor: unit hash
]

{ #category : #accessing }
CSSValue >> unit [

	^ unit
]

{ #category : #accessing }
CSSValue >> value1 [

	^ value
]

{ #category : #'as yet unclassified' }
CSSValue >> value: v unit: u [
	value ifNotNil: [ ^ Error new signal: 'already initialized' ].
	value := v.
	unit := u.
]
