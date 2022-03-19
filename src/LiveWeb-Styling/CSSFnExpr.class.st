Class {
	#name : #CSSFnExpr,
	#superclass : #CSSExpr,
	#instVars : [
		'function',
		'arguments'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #accessing }
CSSFnExpr >> arguments: anObject [

	arguments := anObject
]

{ #category : #converting }
CSSFnExpr >> asCSSPropertyValue [ 
	^ String streamContents: [ :out | out
		<< function; << '('.
		arguments doWithIndex: [ :arg :i | 
			i > 1 ifTrue: [ out << ',' ].
			out << arg asCSSPropertyValue. ].
		out << ')'
	]
]

{ #category : #accessing }
CSSFnExpr >> function: anObject [

	function := anObject
]
