Class {
	#name : #LWClock,
	#superclass : #LWStyledComponent,
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
