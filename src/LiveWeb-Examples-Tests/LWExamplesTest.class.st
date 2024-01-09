"
A LWExamplesTest is a test class for testing the behavior of LWExamples
"
Class {
	#name : #LWExamplesTest,
	#superclass : #PowsTestCase,
	#category : #'LiveWeb-Examples-Tests'
}

{ #category : #running }
LWExamplesTest >> setUp [
	super setUp.
	self timeLimit: (Duration minutes: 1).
	LWExamples start.
]

{ #category : #running }
LWExamplesTest >> tearDown [ 
   LWExamples stop

]

{ #category : #tests }
LWExamplesTest >> testCounter [ 
  self 
  go: 'http://localhost:8080/examples/counter';
  locate: 'div.counter' assert: [ :l | l hasText: '0' ];
  locate: 'button.inc' do: #click;
  locate: 'div.counter' assert: [ :l | l hasText: '1' ];
  locate: 'button.dec' do: [ :b | b click; click ];
  locate: 'div.counter' assert: [ :l | l hasText: '-1' ]

]

{ #category : #tests }
LWExamplesTest >> testMultiCounter [ 
	self
	go: 'http://localhost:8080/examples/multi-counter';
	locate: 'div.counter' assert: [ :d | d hasCount: 5 ];
	locate: #( 'div.counter' 'nth=0' ) assert: [ :d | d hasText: '2' ];
	locate: #( 'div.counter' 'nth=4' ) assert: [ :d | d hasText: '32' ];
	locate: #( 'div.counterComponent' 'nth=0' 'button.inc' ) do: #click;
	locate: #( 'div.counter' 'nth=0' ) assert: [ :d | d hasText: '3' ];
	locate: '#initialCount' do: [ :c | c fill: '42' ];
	locate: #( 'button' 'text=Add new counter' ) do: #click;
	locate: 'div.counter' assert: [ :d | d hasCount: 6 ];
	locate: #( 'div.counter' 'nth=5' ) assert: [ :d | d hasText: '42' ]
	
]
