Class {
	#name : #LWBooleanEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #rendering }
LWBooleanEditor >> renderInput: h hasError: err [
	h input: { 
		#type -> #checkbox.
		#checked -> self currentValue.
		#name -> accessor. 
     #id -> accessor. 
		#onchange -> (Js call: self setter with: (Js inputChecked: accessor)) }
]
