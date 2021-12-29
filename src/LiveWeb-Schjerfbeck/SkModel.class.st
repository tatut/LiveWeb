"
I am the base class for all models.

model, noun. a simplified description of a system or process to assist calculations and predictions.

A model is an abstract description which can be reified to get an instance that can be used to read and write
an actual concrete instance. Model classes that have children must implement postCopy to copy children and 
set their parent to the new copy.
"
Class {
	#name : #SkModel,
	#superclass : #Object,
	#instVars : [
		'readBlock',
		'writeBlock',
		'backingEntity',
		'parent'
	],
	#category : #'LiveWeb-Schjerfbeck'
}

{ #category : #visiting }
SkModel >> accept: aVisitor [
	"accept a visitor for this model node"
	self subclassResponsibility 
]

{ #category : #accessing }
SkModel >> accessor: name [
	"Set read/write accessors by a symbol name. the write accessor 
	is automatically generated from the read accessor by appending ':' to it. "
	| w |
	w := (name asString,':') asSymbol.
	self readBlock: name; 
		  writeBlock: [ :entity :val | entity perform: w with: val ]
]

{ #category : #'accessing - private' }
SkModel >> backingEntity [

	^ backingEntity
]

{ #category : #'accessing - private' }
SkModel >> backingEntity: anObject [

	backingEntity := anObject
]

{ #category : #accessing }
SkModel >> currentValue [
	backingEntity ifNil: [ Error new signal: 'Model is not backed by a real entity.' ].
	^ readBlock value: backingEntity 
	
]

{ #category : #accessing }
SkModel >> currentValue: newValue [
	backingEntity ifNil: [ Error new signal: 'Model is not backed by a real entity.' ].
	writeBlock value: backingEntity value: newValue.
	"process dependencies from this model to others (like conditions)"
	^ newValue
	
]

{ #category : #'accessing - private' }
SkModel >> parent [

	^ parent
]

{ #category : #'accessing - private' }
SkModel >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
SkModel >> readBlock [

	^ readBlock
]

{ #category : #accessing }
SkModel >> readBlock: anObject [

	readBlock := anObject
]

{ #category : #accessing }
SkModel >> reify: aBackingEntity [
	"Make this abstract model into a concrete one, that actually reads/writes some entity.
	Answer with a copy of myself for the backing entity."
	
	^ self copy backingEntity: aBackingEntity.
]

{ #category : #accessing }
SkModel >> writeBlock [

	^ writeBlock
]

{ #category : #accessing }
SkModel >> writeBlock: anObject [

	writeBlock := anObject
]
