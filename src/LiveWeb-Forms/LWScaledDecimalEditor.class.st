"
I am an editor widget for ScaledDecimal values.
"
Class {
	#name : #LWScaledDecimalEditor,
	#superclass : #LWNumericEditor,
	#instVars : [
		'scale'
	],
	#category : #'LiveWeb-Forms'
}

{ #category : #rendering }
LWScaledDecimalEditor >> inputValueString [ 
	| v |
	v := self currentValue.
	v ifNil: ''
	  ifNotNil: [^ String streamContents: [ :out | self currentValue printOn: out showingDecimalPlaces: scale ]]
]

{ #category : #parsing }
LWScaledDecimalEditor >> parseValue: aFormValue [
	^ ScaledDecimal newFromNumber: aFormValue asNumber scale: scale
]

{ #category : #accessing }
LWScaledDecimalEditor >> scale: aScale [
	scale := aScale
]
