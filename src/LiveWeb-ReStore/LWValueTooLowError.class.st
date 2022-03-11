Class {
	#name : #LWValueTooLowError,
	#superclass : #LWValidationError,
	#instVars : [
		'minimum'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #initialization }
LWValueTooLowError >> initialize [
	super initialize.
	message := #valueTooLow
]
