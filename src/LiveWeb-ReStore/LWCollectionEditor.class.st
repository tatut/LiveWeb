Class {
	#name : #LWCollectionEditor,
	#superclass : #LWBaseEditor,
	#instVars : [
		'entityClass',
		'container',
		'createEditorComponent'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #adding }
LWCollectionEditor >> addItem [ 
	"Add new item, writes it to the backing entity and adds a component to the container."
	| collection newItem |
	newItem := entityClass new.
	collection := self form readEnsuring: accessor.
	collection add: newItem.
	
	container add: (self newEditorComponentFor: newItem)
]

{ #category : #'as yet unclassified' }
LWCollectionEditor >> children [
	^ ReadStream on: { container }

]

{ #category : #accessing }
LWCollectionEditor >> createEditorComponent: aBlock [
  "Set a block that creates an editor for an item in this collection.
	Called for existing and new items in the collection."
	createEditorComponent := aBlock
]

{ #category : #accessing }
LWCollectionEditor >> entityClass [

	^ entityClass
]

{ #category : #accessing }
LWCollectionEditor >> entityClass: anObject [

	entityClass := anObject
]

{ #category : #initialization }
LWCollectionEditor >> initialize [ 
  super initialize.
  container := LWContainer new.

]

{ #category : #'component lifecycle' }
LWCollectionEditor >> mount [
	super mount
]

{ #category : #'instance creation' }
LWCollectionEditor >> newEditorComponentFor: entity [ 
	"^ LWBlockContainer new block: [ :h | h div: 'FIXME!', entity printString ]"
	createEditorComponent 
	ifNil: [ 
		"No editor creation block set, try to create a subform."
		^ LWEditForm new
			entity: entity;
			entityClass: entity class;
			yourself ]
	ifNotNil: [ ^ createEditorComponent value: entity ]
	
]

{ #category : #rendering }
LWCollectionEditor >> renderOn: h [
	h div: { self style formCollectionContainer }
	  with: [ 
			container render: h.
			h button: { #onclick -> ((Js call: [ self addItem ]) preventDefault: true) } 
			  with: 'Add new' "FIXME: use messages" 
		]
	

]
