"
I provide human readable labels and other texts for generated forms.
Default implementation just uses the entity class and accessor names and has
no localization based on language.

Override this class and set it to #formMessages in the component context.
"
Class {
	#name : #LWFormMessages,
	#superclass : #Object,
	#category : #'LiveWeb-Forms'
}

{ #category : #'as yet unclassified' }
LWFormMessages >> capitalizedField: forAccessor [
	"Separate numbers and words with spaces and capitalize first."
	| words |
	words := forAccessor splitCamelCase collect: [:w | (w matchesRegex: '([^\d]*)|(\d+)') ifTrue: w ifFalse: false].
	^ String streamContents: [:out |
		out << words first capitalized.
		words allButFirstDo: [:w | out << Character space; << w asLowercase ] ]
]

{ #category : #'as yet unclassified' }
LWFormMessages >> fieldLabel: forAccessor [
	"Answer with a label for an input field."
	^ self capitalizedField: forAccessor
]

{ #category : #'as yet unclassified' }
LWFormMessages >> fieldsetCaption: forAccessor [
	"Answer with a caption for a fieldset, typically a dependent object."
	^ self capitalizedField: forAccessor
]

{ #category : #'as yet unclassified' }
LWFormMessages >> validationError: aValidationError [
	"Format message for validation error.
	Should override this to get actual message from language resources."
	^ self capitalizedField: aValidationError message
]
