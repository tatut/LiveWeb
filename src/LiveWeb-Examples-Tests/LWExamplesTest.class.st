"
A LWExamplesTest is a test class for testing the behavior of LWExamples
"
Class {
	#name : #LWExamplesTest,
	#superclass : #PowsTestCase,
	#category : #'LiveWeb-Examples-Tests'
}

{ #category : #asserting }
LWExamplesTest >> assertDisabled: keys [
	self locate: '[data-disabled=true]' assert: [ :d | d hasCount: keys size ].
	keys do: [ :k |
		self locate: ('[data-key=''{1}'']' format: { k }) assert: [ :kl | kl hasAttribute: 'data-disabled' valued: 'true' ]
	]
]

{ #category : #asserting }
LWExamplesTest >> assertGuess: nth inPosition: inPos inWord: inWord [
 self
 locate: { '.wordleGuess'. 'nth={1}' format: { nth }. '.in-position' } assert: [ :p | p hasCount: inPos ];
 locate: { '.wordleGuess'. 'nth={1}' format: { nth }. '.in-word' } assert: [ :p | p hasCount: inWord ]
]

{ #category : #initialization }
LWExamplesTest >> initialize [ 
  super initialize.
  LWExamples start.
	
]

{ #category : #running }
LWExamplesTest >> setUp [
	super setUp.
	self timeLimit: (Duration minutes: 2).
	
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

{ #category : #tests }
LWExamplesTest >> testTree [
 self
 go: 'http://localhost:8080/examples/tree';
 locate: '.treenode' assert: [ :t | t hasCount: 1 ];
 locate: { (self treeNode: 'Smalltalk packages'). 'button'} do: #click;
 locate: (self treeNode: 'LiveWeb') assert: [ :t | t hasCount: 1 ];
 locate: { self treeNode: 'LiveWeb'. 'button'} do: #click;
 locate: { self treeNode: 'LiveWeb'. self treeNode: 'Examples' } assert: [ :t | t hasCount: 1 ];
 locate: { self treeNode: 'LiveWeb'. self treeNode: 'Examples'. 'button' } do: #click;
 locate: { (self treeNode: 'LWTreeNode'). 'div'. 'span'} assert: [ :t | t hasText: '[Class]' ]
]

{ #category : #tests }
LWExamplesTest >> testTypeahead [ 
  self
  go: 'http://localhost:8080/examples/typeahead';
  locate: 'input#selected' do: [ :i | i pressSequentially: 'LWExamples' ];
  locate: 'div.formCandidates div' assert: [ :c | c hasCount: 3 ];
  locate: '[data-typeahead-id=LWExamples]' do: #click;
  locate: 'div.selectedClass' assert: [ :s | s hasText: 'You have chosen: LWExamples' ]
]

{ #category : #tests }
LWExamplesTest >> testWordle [
 self 
 go: 'http://localhost:8080/examples/wordle?cheat=horse';
 locate: '.wordleGuess' assert: [ :g | g hasCount: 6 ];
 wordleGuess: 'aisle';
 assertGuess: 0 inPosition: 1 inWord: 2;
 assertDisabled: 'ail';
 wordleGuess: 'house';
 assertGuess: 1 inPosition: 4 inWord: 4;
 assertDisabled: 'ailu';
 wordleGuess: 'horse';
 locate: '.centeredDialog' assert: [ :d | d hasText: 'YOU WIN!' ]
]

{ #category : #'as yet unclassified' }
LWExamplesTest >> treeNode: aLabel [ 
 ^ '[data-treenode-label=''{1}'']' format: { aLabel }
]

{ #category : #'as yet unclassified' }
LWExamplesTest >> wordleGuess: word [
 self locate: 'body' do: [ :b | b pressSequentially: word; press: 'Enter' ]
]
