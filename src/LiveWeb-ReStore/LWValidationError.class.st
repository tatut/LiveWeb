Class {
	#name : #LWValidationError,
	#superclass : #Error,
	#instVars : [
		'invalidValue',
		'message'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #creating }
LWValidationError class >> forValue: invalidValue withMessage: message [
	thisContext sender arguments first inspect.
	(self new invalidValue: invalidValue; message: message; yourself) signal
]

{ #category : #creating }
LWValidationError class >> signal: message [
	| value | 
	value := thisContext sender arguments first.
	(self new invalidValue: value; message: message; yourself) signal
]

{ #category : #accessing }
LWValidationError >> invalidValue [

	^ invalidValue
]

{ #category : #accessing }
LWValidationError >> invalidValue: anObject [

	invalidValue := anObject
]

{ #category : #accessing }
LWValidationError >> message [

	^ message
]

{ #category : #accessing }
LWValidationError >> message: anObject [
  "Set the validation message (a symbol) that will be used to translate a UI
  message for this error."
	message := anObject
]
