Class {
	#name : #LWDateEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #rendering }
LWDateEditor >> renderInput: h [
	h input: { #name -> accessor . #id -> accessor . #type -> #date . #onchange -> self setter }
]
