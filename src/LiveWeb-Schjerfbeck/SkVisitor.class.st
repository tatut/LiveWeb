"
A visitor that implements all visitations for model types.
All visitations call the default which is not implemented.

"
Class {
	#name : #SkVisitor,
	#superclass : #Object,
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkVisitor >> visitBoolean: node [ 
	^ self visitDefault: node

]

{ #category : #visiting }
SkVisitor >> visitChoice: node [ 
	^ self visitDefault: node

]

{ #category : #visiting }
SkVisitor >> visitDefault: node [
	self shouldBeImplemented 
]

{ #category : #visiting }
SkVisitor >> visitEntity: node [
	^ self visitDefault: node
]

{ #category : #visiting }
SkVisitor >> visitGroup: node [ 
	^ self visitDefault: node

]

{ #category : #visiting }
SkVisitor >> visitMulti: node [ 
	^ self visitDefault: node

]

{ #category : #visiting }
SkVisitor >> visitNumber: node [ 
	^ self visitDefault: node

]

{ #category : #visiting }
SkVisitor >> visitText: node [ 
	^ self visitDefault: node

]
