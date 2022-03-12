"
I am the base class for components that provide UI editors.

I render the input field, and handle setting the new value when it changes.

I am contained in a form and use that to read/write the value I operate on.

I keep a separate child component that displays a possible error message for the field.
It is needed so that changing the error doesn't rerender the whole input component, because
that would cause the focus to be lost.
 

"
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
	errorComponent := LWFormError new 


]

{ #category : #parsing }
LWBaseEditor >> parseValue: aFormValue [
	"Parse string form value (if needed) to instance. Default returns string as is."
	^ aFormValue
	
]

{ #category : #rendering }
LWBaseEditor >> renderInput: h hasError: aBoolean [
	h div: 'FIXME: implement renderInput for ', self class asString.
	"self subclassResponsibility" 
]

{ #category : #rendering }
LWBaseEditor >> renderInputAndError: h [
  h div: {self style formInputAndError} with: [
		 self renderInput: h hasError: errorMessage isNotNil.
      errorComponent render: h
	]
]

{ #category : #rendering }
LWBaseEditor >> renderOn: h [
	showLabel
	ifTrue: [
		"render with additional HTML structure that has place for label and input" 
		h div: { self style formField } with: [ 
 			h label: { #for -> accessor. self style formFieldLabel } 
			  with: (self messages fieldLabel: accessor).
 			self renderInputAndError: h ]]
	ifFalse: [ self renderInputAndError: h ]
]

{ #category : #accessing }
LWBaseEditor >> setter [
	"answer with a setter block that can be used as an onchange callback"
	^ [ :v | 
			[ form write: accessor value: (self parseValue: v).
				errorComponent hasError ifTrue: [ 
				  "clear error message and error style, if setting worked"
           errorComponent clearErrorMessage.
           self send: '-C' with: (self style formFieldError) value
         ]
			] on: Error 
			  do: [ :e | 
				"If we catch an error setting the value, set error for this field."				
				errorComponent errorMessage: (self messages validationError: e).
			  self send: '+C' with: (self style formFieldError) value

			  ]
		]
]

{ #category : #accessing }
LWBaseEditor >> showLabel [ 
   showLabel := true

]
