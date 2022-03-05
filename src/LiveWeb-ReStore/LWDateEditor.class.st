Class {
	#name : #LWDateEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #parsing }
LWDateEditor >> parseValue: aFormValue [
	^ aFormValue asDate
]

{ #category : #rendering }
LWDateEditor >> renderInput: h [
	h input: { 
		#name -> accessor . 
		#id -> accessor . 
		#type -> #date . 
		#onchange -> (Js call: self setter with: (Js inputValue: accessor)) }
]
