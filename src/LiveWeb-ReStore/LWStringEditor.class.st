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
	h input: { 
		 #type -> #text.
		 #name -> accessor. 
		 #id -> accessor. 
		 #maxlength -> maxLength.
		 #value -> (self currentValue: #yourself).
		#onchange -> (Js call: self setter with: (Js inputValue: accessor)) }
]
