"
A LWStyleBuilderTest is a test class for testing the behavior of LWStyleBuilder
"
Class {
	#name : #LWStyleBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		's'
	],
	#category : #'LiveWeb-Styling-Tests'
}

{ #category : #running }
LWStyleBuilderTest >> setUp [
	super setUp.
	
	s := LWStyleBuilder new.
]

{ #category : #tests }
LWStyleBuilderTest >> testLastPropertyWins [
   | css |
	s fontSize: 10px.
	s margin: 0.5rem.
	s fontSize: 42px.
	css := String streamContents: [ :out | s writeOn: out ].
	self assert: (css includesSubstring: 'font-size: 42px;') description: 'has later style that overwrites initial'.
	self assert: (css includesSubstring: 'font-size: 10px;') not description: 'does not have initial style'.
	self assert: (css includesSubstring: 'margin: 0.5rem;') description: 'has other style'.
]
