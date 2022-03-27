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
	self assert: (cls value includesSubstring: 'myContainer:background:margin:')
		description: 'Generated class name has method selector'.
	self assert: (cls value endsWith: hash)
		description: 'Generated class ends with hash of arguments'.
	
	"generate big text"
	cls := ts bigText: 3.
	self assert: cls value equals: ('big<1s>' expandMacrosWith: { 3 } hash asString).
	
	"check generated CSS has the classes"
	css := (String streamContents: [ :out | ts writeOn: out ]) lines .
	self assert: ((css at: 1) beginsWith: ('.myContainer\:background\:margin\:<1s>  { ' expandMacrosWith: hash)) description: '1st rule starts with correct selector'.
	self assert: ((css at: 1) includesSubstring: 'display: flex;') description: 'has flex property'.
	self assert: ((css at: 1) includesSubstring: 'flex-direction: col;') description: 'has flex-direction property'.
	self assert: ((css at: 1) includesSubstring: 'background-color: wheat;') description: 'has bacground-color property'.
	self assert: ((css at: 1) includesSubstring: 'margin: 2px;') description: 'has margin property'.
	
	self assert: ((css at: 2) beginsWith: ('.big<1s>' expandMacrosWith: {3} hash asString)) description: '2nd rule starts with correct selector'.
	self assert: ((css at: 2) includesSubstring: 'font-size: calc(10px * 3);') description: 'has font-size property'.
		
]
