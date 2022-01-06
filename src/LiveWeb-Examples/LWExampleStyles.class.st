Class {
	#name : #LWExampleStyles,
	#superclass : #LWStylesheetProvider,
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWExampleStyles >> clockFace [ 
	^ self style: [:s | s strokeWidth: 2px; stroke: 'wheat' ]
]

{ #category : #'as yet unclassified' }
LWExampleStyles >> clockHands [
	^ self style: [ :s | s strokeWidth: 1px; fill: '#333'; stroke: '#555']

]

{ #category : #initialization }
LWExampleStyles >> initialize [
	super initialize
]
