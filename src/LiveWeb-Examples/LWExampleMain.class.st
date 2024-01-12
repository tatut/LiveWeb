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
		'menu'
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
	| ex |
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

	"set the child component to a new instance and change active item for menu"
	example child: ex new.
	menu active: (state at: 'example').
]
