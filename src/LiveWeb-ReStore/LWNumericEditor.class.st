Class {
	#name : #LWNumericEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
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
