Class {
	#name : #LWFloatEditor,
	#superclass : #LWNumericEditor,
	#category : #'LiveWeb-Forms'
}

{ #category : #parsing }
LWFloatEditor >> parseValue: aFormValue [ 
	^ aFormValue asNumber asFloat 
]
