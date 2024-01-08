"
A LWExamplesTest is a test class for testing the behavior of LWExamples
"
Class {
	#name : #LWExamplesTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Examples-Tests'
}

{ #category : #tests }
LWExamplesTest >> testUsingPlaywright [ 
   "Note: this should be run in GitHub Actions CI only"
	| result | 
	result := (LibC resultOfCommand: '/home/runner/work/LiveWeb/LiveWeb/playwright/run.sh') lines last.
	self assert: result equals: '0 failures, 0 errors.' 
	
]
