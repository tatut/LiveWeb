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
	| ts css hash cls |
	ts := LWTestsheet new.
	cls := ts myContainer: 'col' background: 'wheat' margin: 2px.
	hash := {'col'.'wheat'. 2px} hash asString.
	self assert: (cls includesSubstring: 'myContainer:background:margin:')
		description: 'Generated class name has method selector'.
	self assert: (cls endsWith: hash)
		description: 'Generated class ends with hash of arguments'.
		
	css := String streamContents: [ :out | ts writeOn: out ].
	self assert: css 
		equals: ('myContainer\:background\:margin\:<1s> { display: flex; flex-direction: col; background-color: wheat; margin: 2px; }<n>'
					expandMacrosWith: hash)
		
]
