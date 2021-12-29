"
I model an a field whose value is text (some string type).
"
Class {
	#name : #SkText,
	#superclass : #SkModel,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkText >> accept: aVisitor [
	^ aVisitor visitText: self
]
