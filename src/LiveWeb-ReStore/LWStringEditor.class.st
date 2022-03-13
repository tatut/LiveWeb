"
I am an editor component for strings.
"
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
LWStringEditor >> renderInput: h hasError: aBoolean [
	h input: { 
		self style formInput: aBoolean.
		 #type -> #text.
		 #name -> accessor. 
		 #id -> accessor. 
		 #maxlength -> maxLength.
		 #value -> (self currentValue: #yourself).
		#onchange -> (Js call: self setter with: (Js inputValue: accessor)) }
]
