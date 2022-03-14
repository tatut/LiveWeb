Class {
	#name : #LWFloatEditor,
	#superclass : #LWNumericEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #parsing }
LWFloatEditor >> parseValue: aFormValue [ 
	^ aFormValue asNumber asFloat 
]
