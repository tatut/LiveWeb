Class {
	#name : #LWStringEditor,
	#superclass : #LWBaseEditor,
	#instVars : [
		'maxLength'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWStringEditor >> maxLength: aPositiveInteger [
	maxLength := aPositiveInteger 
]

{ #category : #rendering }
LWStringEditor >> renderInput: h [
	h input: { #type -> #text. #name -> accessor. #id -> accessor. #maxlength -> maxLength .
		#onchange -> (Js call: self setter with: (Js inputValue: accessor)) }
]

{ #category : #accessing }
LWStringEditor >> setter [
	"answer with a setter block that can be used as an onchange callback"
	| sel |
	sel := (accessor,':') asSymbol.
	^ [ :v | entity perform: sel with: v ]
]
