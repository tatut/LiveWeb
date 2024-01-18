"
I am the main component for the example page. 
I render a menu that allows navigating to different examples. 
I hold the current example component.
"
Class {
	#name : #LWExampleMain,
	#superclass : #LWStyledComponent,
	#instVars : [
		'state',
		'example',
		'menu',
		'check',
		'alert'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWExampleMain >> children [ 
	^ ReadStream on: { example . menu. check. alert }
]

{ #category : #rendering }
LWExampleMain >> htmlRendererClass [  
 ^ SlHTMLRenderer 

]

{ #category : #initialization }
LWExampleMain >> initialize [
	super initialize.
	example := LWSingleContainer new.
	menu := LWExampleMenu new.
	check := SlCheckbox new
		label: 'is shoelace cool?';
		on: SlCheckboxEvent  do: [ :e | Transcript show: 'it is cool? ', e printString; cr ].
	alert := LWSwitch new off; child: (SlAlert new default: 'yes it is very cool').
]

{ #category : #rendering }
LWExampleMain >> renderOn: h [
	h div: [ 
		menu render: h.
		check render: h.
		h div: { #class -> 'example box' } with: [ 
			example render: h 
		]
	]
]

{ #category : #accessing }
LWExampleMain >> state: aDictionary [
	| ex component |
	state := aDictionary.
	
	"check push state for example to use"
	ex := { 
		'wordle' -> LWWordle . 
		'clock' -> LWClockExample . 
		'counter' -> LWCounter . 
		'multi-counter' -> LWMultiCounter . 
		'crud' -> LWCrudExample.
		'typeahead' -> LWTypeAheadExample.
		'tree' -> LWTreeExample } asDictionary at: (state at: 'example').
	"create new instance of example component"
	component := ex new.
	ex = LWWordle ifTrue: [ component configure: (state at: 'query') ]. "for tests"
	
	"set the child component to the example instance"
	example child: component.
	
	menu active: (state at: 'example').
]
