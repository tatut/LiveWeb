Class {
	#name : #LWBaseEditor,
	#superclass : #LWFormComponent,
	#instVars : [
		'showLabel',
		'errorComponent',
		'errorMessage'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWBaseEditor >> children [ 
	^ ReadStream on: { errorComponent }
]

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

{ #category : #accessing }
LWBaseEditor >> hideLabel [ 
   showLabel := false

]

{ #category : #initialization }
LWBaseEditor >> initialize [ 
	super initialize.
	showLabel := true.
	errorComponent := LWSingleContainer new.


]

{ #category : #'component lifecycle' }
LWBaseEditor >> mount [
	errorComponent := LWSingleContainer new.
	super mount 
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
	showLabel
	ifTrue: [ 
		h div: { self style formField } with: [ 
 			h label: { #for -> accessor. self style formFieldLabel } 
			  with: (self messages fieldLabel: accessor).
 			self renderInput: h ]]
	ifFalse: [ self renderInput: h ]
]

{ #category : #accessing }
LWBaseEditor >> setter [
	"answer with a setter block that can be used as an onchange callback"
	^ [ :v | 
			[ form write: accessor value: (self parseValue: v).
			  errorComponent child: nil. "clear error if setting field worked"
			] on: Error 
			  do: [ :e | 
				"If we catch an error setting the value, set error component for this field."
				errorComponent := LWBlockContainer new block: [ :h | h div: 'Error: ', e asString ] ]
			]
]

{ #category : #accessing }
LWBaseEditor >> showLabel [ 
   showLabel := true

]
