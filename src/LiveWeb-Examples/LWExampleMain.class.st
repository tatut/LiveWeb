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
	^ ReadStream on: { example . menu }
]

{ #category : #initialization }
LWExampleMain >> initialize [
	super initialize.
	example := LWSingleContainer new.
	menu := LWExampleMenu new.
]

{ #category : #rendering }
LWExampleMain >> renderOn: h [
	h div: [ 
		menu render: h.
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
		'tree' -> LWTreeExample.
		'todo' -> LWTodoExample } asDictionary at: (state at: 'example').
	"create new instance of example component"
	component := ex new.
	ex = LWWordle ifTrue: [ component configure: (state at: 'query') ]. "for tests"
	
	"set the child component to the example instance"
	example child: component.
	
	menu active: (state at: 'example').
]
