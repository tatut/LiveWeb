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
LWCrudExample >> entity: anEntity [ 
	entity := anEntity.
	form := LWEditForm forEntityClass: entity class.
	form exclude: #name;
		   entity: entity.
	
]

{ #category : #initialization }
LWCrudExample >> initialize [ 
	super initialize.
	entity := Customer new.
	form := LWEditForm forEntityClass: entity class.
	form exclude: #name;
		   entity: entity.
	
]

{ #category : #rendering }
LWCrudExample >> renderOn: h [
	h div: [ 
		h span: 'editor form here'.
		form render: h
   ]
]
