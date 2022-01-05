"
A LWStyleTest is a test class for testing the behavior of LWStyle
"
Class {
	#name : #LWStyleTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Styling-Tests'
}

{ #category : #'as yet unclassified' }
LWStyleTest >> css: block [
 ^ String streamContents: [ :out | block value: (LWStyle on: out) ] .
]

{ #category : #tests }
LWStyleTest >> testCalc [
	self assert: (self css: [ :s | s width: 90vw - 20px ])
		equals: 'width: calc(90vw - 20px); '.
	
	self assert: (self css: [ :s | s margin: 0.5rem * 2 / 7 ])
		equals: 'margin: calc(calc(0.5rem * 2) / 7); '
]

{ #category : #tests }
LWStyleTest >> testStyles [ 
	self assert: (self css: [ :s | s width: 33vw; margin: 2px ])
		equals: 'width: 33vw; margin: 2px; '
]
