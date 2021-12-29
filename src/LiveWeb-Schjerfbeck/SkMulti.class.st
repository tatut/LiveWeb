"
I represent a field whose value is a collection of multiple values.
The type of the values is modeled by the inner model.
"
Class {
	#name : #SkMulti,
	#superclass : #SkModel,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkMulti >> accept: aVisitor [
	^ aVisitor visitMulti: self
]
