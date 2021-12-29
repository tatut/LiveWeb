"
I model a field whose value is a number.
"
Class {
	#name : #SkNumber,
	#superclass : #SkModel,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkNumber >> accept: aVisitor [
	^ aVisitor visitNumber: self
]
