"
I represent a field whose value is selected from a set of distinct choices.
"
Class {
	#name : #SkChoice,
	#superclass : #SkModel,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkChoice >> accept: aVisitor [
	^ aVisitor visitChoice: self
]
