Class {
	#name : #LWCrudCreateState,
	#superclass : #LWCrudState,
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWCrudCreateState >> entityToEdit [ 
	^ self tableClass new
]
