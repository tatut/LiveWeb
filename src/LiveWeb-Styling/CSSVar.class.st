Class {
	#name : #CSSVar,
	#superclass : #CSSExpr,
	#instVars : [
		'var'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #converting }
CSSVar >> asCSSPropertyValue [ 
 ^ 'var(--<1s>)' expandMacrosWith: var asString.
]

{ #category : #accessing }
CSSVar >> var: name [ 
  var := name 

]
