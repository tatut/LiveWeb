"
I model a group of related fields.
"
Class {
	#name : #SkGroup,
	#superclass : #SkModel,
	#instVars : [
		'models'
	],
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkGroup >> accept: aVisitor [
	^ aVisitor visitGroup: self
]

{ #category : #adding }
SkGroup >> add: aModel [
	aModel parent: self.
	models add: aModel.
	
]

{ #category : #initialization }
SkGroup >> initialize [ 
	super initialize.
	models := OrderedCollection new.

]

{ #category : #copying }
SkGroup >> postCopy [
	models := models select: [ :m | m copy parent: self ]
]
