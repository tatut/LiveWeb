"
A LWStylesheetProviderTest is a test class for testing the behavior of LWStylesheetProvider
"
Class {
	#name : #LWStylesheetProviderTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Styling-Tests'
}

{ #category : #tests }
LWStylesheetProviderTest >> testSheet [
	| ts cls |
	ts := LWTestsheet new.
	cls := ts myContainer: 'col' background: 'wheat' margin: 2px.
	self assert: (cls includesSubstring: 'myContainer:background:margin:')
		description: 'Generated class name has method selector'.
	self assert: (cls endsWith: {'col'.'wheat'. 2px} hash asString)
		description: 'Generated class ends with hash of arguments'
]
