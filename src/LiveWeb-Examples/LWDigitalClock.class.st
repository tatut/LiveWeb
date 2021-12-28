Class {
	#name : #LWDigitalClock,
	#superclass : #LWClock,
	#category : #'LiveWeb-Examples'
}

{ #category : #rendering }
LWDigitalClock >> renderOn: h [
	h div: time print24.
]
