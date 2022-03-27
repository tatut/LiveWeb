"
I am the base class for editor widgets that edit numerical values.
"
Class {
	#name : #LWNumericEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-Forms'
}

{ #category : #rendering }
LWNumericEditor >> inputValueString [
  ^self currentValue: #asString
]

{ #category : #rendering }
LWNumericEditor >> renderInput: h hasError: aBoolean [
  h input: {(self style formInput: aBoolean) . 
        (#type -> #number) . 
        (#step -> 1) . 
        (#name -> accessor) . 
        (#id -> accessor) . 
        (#value -> self inputValueString) . 
        (#onchange -> self setterCallback)}
]
