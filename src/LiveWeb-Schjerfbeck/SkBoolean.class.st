"
I model a simple yes/no question where the value is either true or false.
"
Class {
	#name : #SkBoolean,
	#superclass : #SkModel,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkBoolean >> accept: aVisitor [
	^ aVisitor visitBoolean: self
]
