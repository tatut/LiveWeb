Class {
	#name : #LWBaseEditor,
	#superclass : #LWStyledComponent,
	#instVars : [
		'accessor',
		'entity'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWBaseEditor >> accessor: aSymbol [
	"Set the name of the read accessor, the writer is the same but with colon added."
	accessor := aSymbol
]

{ #category : #accessing }
LWBaseEditor >> entity: anEntity [
	entity := anEntity 
]

{ #category : #rendering }
LWBaseEditor >> renderInput: h [
	self subclassResponsibility 
]

{ #category : #rendering }
LWBaseEditor >> renderOn: h [
	h div: { #class -> 'formField' } with: [ 
		h label: { #for -> accessor } with:  accessor asString.
		self renderInput: h
   ]
]
