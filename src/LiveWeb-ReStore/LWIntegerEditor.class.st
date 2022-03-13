Class {
	#name : #LWIntegerEditor,
	#superclass : #LWNumericEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #parsing }
LWIntegerEditor >> parseValue: aFormValue [
	^ aFormValue asInteger
]
