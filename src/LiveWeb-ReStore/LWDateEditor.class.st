Class {
	#name : #LWDateEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #parsing }
LWDateEditor >> parseValue: aFormValue [
	^ [aFormValue asDate] on: Error do: [ :sig | sig return: nil ] 
]

{ #category : #rendering }
LWDateEditor >> renderInput: h hasError: aBoolean [
	h input: { 
		self style formInput: aBoolean.
		#name -> accessor . 
		#id -> accessor . 
		#type -> #date . 
		#value -> (self currentValue: #yyyymmdd) .
		#onchange -> (Js call: self setter with: (Js inputValue: accessor)) }
]