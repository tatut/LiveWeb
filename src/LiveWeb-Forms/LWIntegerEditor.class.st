Class {
	#name : #LWIntegerEditor,
	#superclass : #LWNumericEditor,
	#category : #'LiveWeb-Forms'
}

{ #category : #parsing }
LWIntegerEditor >> parseValue: aFormValue [
	^ aFormValue asInteger
]
