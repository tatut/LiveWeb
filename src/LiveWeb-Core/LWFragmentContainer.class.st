"
I am a raw fragment container that has no parent element.
It just renders all children as is.

This component cannot be rerendered, only the individual children can.
"
Class {
	#name : #LWFragmentContainer,
	#superclass : #LWContainer,
	#instVars : [
		'rendered'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #adding }
LWFragmentContainer >> add: aComponentOrString [ 
 aComponentOrString isString 
	ifTrue: [ super add: 
		(LWBlockContainer new block: [:h | h raw: aComponentOrString ]) ]
	ifFalse: [ super add: aComponentOrString ].
^ aComponentOrString 
]

{ #category : #initialization }
LWFragmentContainer >> initialize [ 
 super initialize.
 rendered := false.
]

{ #category : #rendering }
LWFragmentContainer >> renderOn: h [
	self assert: [ rendered not ].
	rendered := true.
	self renderChildren: h.
]
