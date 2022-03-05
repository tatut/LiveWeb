"
I am the baseclass for components that can access an entity field. I do the access via parent form and accessor.
"
Class {
	#name : #LWFormComponent,
	#superclass : #LWStyledComponent,
	#instVars : [
		'form',
		'accessor'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWFormComponent >> accessor [

	^ accessor
]

{ #category : #accessing }
LWFormComponent >> accessor: aFieldAccessorSymbol [
	accessor := aFieldAccessorSymbol 
]

{ #category : #accessing }
LWFormComponent >> form [

	^ form
]

{ #category : #accessing }
LWFormComponent >> form: anLWEditForm [
	form := anLWEditForm 
]
