Class {
	#name : #LWCrudEditState,
	#superclass : #LWCrudState,
	#instVars : [
		'id'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWCrudEditState >> entityToEdit [ 
	^ (self tableClass storedInstances detect: [ :row | row _id = id ]) refresh; yourself
]

{ #category : #accessing }
LWCrudEditState >> id [

	^ id
]

{ #category : #accessing }
LWCrudEditState >> id: anObject [

	id := anObject
]
