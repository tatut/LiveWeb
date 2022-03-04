Class {
	#name : #LWCrudExample,
	#superclass : #LWStyledComponent,
	#instVars : [
		'entity',
		'form'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWCrudExample >> children [
	^ ReadStream on: { form }
]

{ #category : #initialization }
LWCrudExample >> initialize [ 
	super initialize.
	entity := Address new.
	form := LWEditForm forEntityClass: entity class.
	form entity: entity.
	
]

{ #category : #rendering }
LWCrudExample >> renderOn: h [
	h div: [ 
		h span: 'editor form here'.
		form render: h
   ]
]
