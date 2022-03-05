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
	h div: 'FIXME: implement renderInput for ', self class asString.
	"self subclassResponsibility" 
]

{ #category : #rendering }
LWBaseEditor >> renderOn: h [
	h div: { #class -> 'formField' } with: [ 
		h label: { #for -> accessor } with:  accessor asString.
		self renderInput: h
   ]
]

{ #category : #accessing }
LWBaseEditor >> setter [
	"answer with a setter block that can be used as an onchange callback"
	| sel |
	sel := (accessor,':') asSymbol.
	^ [ :v | entity perform: sel with: v ]
]
