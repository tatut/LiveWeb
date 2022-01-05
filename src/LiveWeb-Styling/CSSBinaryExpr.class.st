Class {
	#name : #CSSBinaryExpr,
	#superclass : #CSSExpr,
	#instVars : [
		'left',
		'right',
		'op'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #converting }
CSSBinaryExpr >> asCSSPropertyValue [ 
	^ self asCSSPropertyValue: false
]

{ #category : #converting }
CSSBinaryExpr >> asCSSPropertyValue: nested [ 
	^ '<1s>(<2s> <3s> <4s>)' 
		expandMacrosWith: (nested ifTrue: '' ifFalse: 'calc')
		with: left asCSSPropertyValueNested 
		with: op 
		with: right asCSSPropertyValueNested 
]

{ #category : #converting }
CSSBinaryExpr >> asCSSPropertyValueNested [ 
	^ self asCSSPropertyValue: true
]

{ #category : #testing }
CSSBinaryExpr >> isCSSCalculated [ 
  ^ true

]

{ #category : #accessing }
CSSBinaryExpr >> left: anObject [

	left := anObject
]

{ #category : #accessing }
CSSBinaryExpr >> op: operation [ 
	op := operation
]

{ #category : #accessing }
CSSBinaryExpr >> right: anObject [

	right := anObject
]
