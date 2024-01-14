Class {
	#name : #LWMockContext,
	#superclass : #Object,
	#instVars : [
		'nextId',
		'patches'
	],
	#category : #'LiveWeb-Core-Tests'
}

{ #category : #adding }
LWMockContext >> addPatchesTo: addable for: componentId [ 
	"Set object to add patches to for the given component id.
	Addable must be an object that undestands #add: message".
	self patches at: componentId put: addable
]

{ #category : #accessing }
LWMockContext >> patches [
 patches ifNil: [ patches := Dictionary new ].
 ^ patches
]

{ #category : #registering }
LWMockContext >> registerComponent: c [
   | id |
	nextId ifNil: [ nextId := 0 ].
	id := nextId.
	nextId := nextId + 1.
	self addPatchesTo: OrderedCollection new for: id. 
	^ id
]

{ #category : #'client control' }
LWMockContext >> send: type for: componentId with: content [ 
 (self patches at: componentId ifAbsent: [ ^ self ])
	add: type -> content
]
