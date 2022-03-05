Class {
	#name : #LWBaseEditor,
	#superclass : #LWFormComponent,
	#category : #'LiveWeb-ReStore'
}

{ #category : #parsing }
LWBaseEditor >> parseValue: aFormValue [
	"Parse string form value (if needed) to instance. Default returns string as is."
	^ aFormValue
	
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
	^ [ :v | form write: accessor value: (self parseValue: v) ]
]
