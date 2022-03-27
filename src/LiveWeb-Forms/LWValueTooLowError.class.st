"
I represent a validation error of a value below the given minimum.
"
Class {
	#name : #LWValueTooLowError,
	#superclass : #LWValidationError,
	#instVars : [
		'minimum'
	],
	#category : #'LiveWeb-Forms'
}

{ #category : #initialization }
LWValueTooLowError >> initialize [
	super initialize.
	message := #valueTooLow
]
