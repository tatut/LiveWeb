Class {
	#name : #LWClock,
	#superclass : #LWComponent,
	#instVars : [
		'time'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWClock >> time: anObject [
	time := anObject.
	self changed.
]
