"
I am the base class for component tests. I setup a mock context that can
be used to render components as strings.
"
Class {
	#name : #LWComponentTest,
	#superclass : #TestCase,
	#instVars : [
		'ctx',
		'component'
	],
	#category : #'LiveWeb-Core-Tests'
}

{ #category : #accessing }
LWComponentTest >> patches [ 
 ^ self patches: component
]

{ #category : #accessing }
LWComponentTest >> patches: forComponent [ 
 ^ctx patches at: forComponent id
]

{ #category : #rendering }
LWComponentTest >> render: c [
	"Render component to string"
	c inContext: ctx. 
	component := c.
	^ String streamContents: [ :out |
		c render: (HTMLRenderer on: out)	
	 ]
	 
]

{ #category : #running }
LWComponentTest >> setUp [
	super setUp.
	ctx := LWMockContext new.
]
