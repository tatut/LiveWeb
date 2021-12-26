Class {
	#name : #LWContext,
	#superclass : #Object,
	#instVars : [
		'nextId'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #initialization }
LWContext >> initialize [
	nextId := 0.
]

{ #category : #'as yet unclassified' }
LWContext >> nextComponentId [
	| id |
	id := nextId.
	nextId := nextId + 1.
	^ id
]
