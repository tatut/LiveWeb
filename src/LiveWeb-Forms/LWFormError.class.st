"
I show an error message (or placeholder script if error is nil).
"
Class {
	#name : #LWFormError,
	#superclass : #LWStyledComponent,
	#instVars : [
		'errorMessage'
	],
	#category : #'LiveWeb-Forms'
}

{ #category : #'as yet unclassified' }
LWFormError >> clearErrorMessage [
	| needRender |
	needRender := errorMessage isNotNil.
	errorMessage := nil.
	needRender ifTrue: [ self changed ]
]

{ #category : #accessing }
LWFormError >> errorMessage [

	^ errorMessage
]

{ #category : #accessing }
LWFormError >> errorMessage: anObject [
	errorMessage := anObject.
	self changed
]

{ #category : #testing }
LWFormError >> hasError [ 
  ^ errorMessage isNotNil

]

{ #category : #rendering }
LWFormError >> renderOn: h [
	errorMessage 
		ifNotNil: [ h div: { self style formErrorMessage } with: errorMessage ]
		ifNil: [ h script: { #type -> 'liveweb/placeholder' } with: '' ]
]
