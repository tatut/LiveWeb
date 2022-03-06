Class {
	#name : #LWBaseEditor,
	#superclass : #LWFormComponent,
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWBaseEditor >> currentValue [
	^ form read: accessor
]

{ #category : #accessing }
LWBaseEditor >> currentValue: aBlock [ 
  "Format current value for form, if value is nil defaults to empty string."
	| v |
	v := form read: accessor.
	v ifNil: [ ^ '' ] ifNotNil: [ ^ aBlock value: v ]
]

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
	h div: { self style formField } with: [ 
		h label: { #for -> accessor. self style formFieldLabel } with: (self messages fieldLabel: accessor).
		self renderInput: h
   ]
]

{ #category : #accessing }
LWBaseEditor >> setter [
	"answer with a setter block that can be used as an onchange callback"
	^ [ :v | form write: accessor value: (self parseValue: v) ]
]
