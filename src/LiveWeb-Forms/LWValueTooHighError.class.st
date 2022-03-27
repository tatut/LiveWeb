"
I represent a validation error of a value being above the given maximum.

"
Class {
	#name : #LWValueTooHighError,
	#superclass : #LWValidationError,
	#instVars : [
		'maximum'
	],
	#category : #'LiveWeb-Forms'
}

{ #category : #initialization }
LWValueTooHighError >> initialize [
	super initialize.
	message := #valueTooHigh.
]
