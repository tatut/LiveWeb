"
I am an editor widget for floating point numbers.
"
Class {
	#name : #LWFloatEditor,
	#superclass : #LWNumericEditor,
	#category : #'LiveWeb-Forms'
}

{ #category : #parsing }
LWFloatEditor >> parseValue: aFormValue [ 
	^ aFormValue asNumber asFloat 
]
