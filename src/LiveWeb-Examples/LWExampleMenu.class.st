Class {
	#name : #LWExampleMenu,
	#superclass : #LWBulmaComponent,
	#instVars : [
		'active'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWExampleMenu >> active: activeItem [
	active := activeItem.
	self changed.
]

{ #category : #'as yet unclassified' }
LWExampleMenu >> onactivate: exampleName [ 
  | location |
  location := '/examples/',exampleName.
  ctx go: location with: { #example -> exampleName } asDictionary
]

{ #category : #accessing }
LWExampleMenu >> view: build [ 
	^build tabs 
		onchange: [ :tab | self onactivate: tab ];
		active: active;
		tab: 'Counter' -> 'counter';
		tab: 'Multi counter' -> 'multi-counter';
		tab: 'Wordle' -> 'wordle';
		tab: 'Clock' -> 'clock';
		tab: 'Typeahead' -> 'typeahead';
		tab: 'Tree' -> 'tree'
		
]
