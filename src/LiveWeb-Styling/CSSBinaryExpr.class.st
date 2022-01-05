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
	^ 'calc(<1s> <2s> <3s>)' 
		expandMacrosWith: left asCSSPropertyValue 
		with: op 
		with: right asCSSPropertyValue 
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
