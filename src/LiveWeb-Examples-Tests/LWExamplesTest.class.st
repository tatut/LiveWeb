"
A LWExamplesTest is a test class for testing the behavior of LWExamples
"
Class {
	#name : #LWExamplesTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Examples-Tests'
}

{ #category : #running }
LWExamplesTest >> setUp [
	super setUp.

	LWExamples start.
]

{ #category : #running }
LWExamplesTest >> tearDown [ 
   LWExamples stop

]

{ #category : #tests }
LWExamplesTest >> testUsingPlaywright [ 
   "Note: this should be run in GitHub Actions CI only"
	| file | 
	LibC system: '/home/runner/work/LiveWeb/LiveWeb/playwright/run.sh &'.
	file := FileLocator root / 'home' / 'runner' / 'work' / 'LiveWeb' / 'LiveWeb' / 'playwright' / 'test.done'.
	Transcript show: 'File: ', file asString; cr.
	[ file exists ] whileFalse: [ (Delay forSeconds: 1) wait ].
   Transcript show: 'test.done contains: ', file contents; cr.
	self assert: file contents lines last equals: '0 failures, 0 errors.'.
	
]
