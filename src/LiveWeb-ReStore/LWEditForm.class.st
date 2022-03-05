Class {
	#name : #LWEditForm,
	#superclass : #LWStyledComponent,
	#instVars : [
		'reStoreDefinition',
		'entity',
		'childComponents'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #'as yet unclassified' }
LWEditForm class >> forEntityClass: anEntityClass [
	"Answer with a new LWEditForm instance for the given ReStore entity class. The entity must be set before mounting."
	^ self new reStoreDefinition: (anEntityClass reStoreDefinition); yourself
]

{ #category : #accessing }
LWEditForm >> childComponents: anObject [

	childComponents := anObject
]

{ #category : #accessing }
LWEditForm >> children [
	^ReadStream on: childComponents 
]

{ #category : #accessing }
LWEditForm >> entity [

	^ entity
]

{ #category : #accessing }
LWEditForm >> entity: anObject [

	entity := anObject
]

{ #category : #initialization }
LWEditForm >> initialize [ 
	super initialize.
	childComponents := {}.

]

{ #category : #'component lifecycle' }
LWEditForm >> mount [
	"Create edit components for all children in ReStore definition."
	childComponents := reStoreDefinition instVarDefinitions collect: [ :d | 
		Transcript show: d key asString, ' has component ', d value printString;cr.
		(d value asLWEditFormComponent: entity) accessor: d key; yourself ]
]

{ #category : #accessing }
LWEditForm >> reStoreDefinition: anObject [

	reStoreDefinition := anObject
]

{ #category : #rendering }
LWEditForm >> renderOn: h [
	h div: { #class -> 'editForm' } with: [ 
		childComponents do: [ :c | c render: h ]
   ]
]
