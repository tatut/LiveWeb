Class {
	#name : #LWWordleKeyboard,
	#superclass : #LWStyledComponent,
	#instVars : [
		'game',
		'disabledKeys'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWWordleKeyboard >> disableKeys: someKeys [
	disabledKeys addAll: someKeys.
	self changed.
]

{ #category : #accessing }
LWWordleKeyboard >> game: aGame [
 game := aGame
]

{ #category : #initialization }
LWWordleKeyboard >> initialize [ 
  super initialize.
  disabledKeys := Set new.

]

{ #category : #rendering }
LWWordleKeyboard >> renderOn: h [
  "render a keyboard in three rows, pressing key calls game methods to type"
	h div: { self style wordleKeyboard } with: [ 
		#('qwertyuiop' 'asdfghjkl' 'zxcvbnm') do: [ :row |
			h div: { self style wordleKeyboardRow } with: [ 
				| last |
				last := (row at: 1) = $z.
				last ifTrue: [ h button: { #onclick -> [ game enter ] } with: 'ENTER' ].
				row do: [ :ch |
					h div: { self style wordleKeyboardKey: (disabledKeys includes: ch). #onclick -> [ game type: ch ] }
						with: ch 
				].
				last ifTrue: [ h button: { #onclick -> [ game backspace ] } with: 'BACKSPACE' ]
			]
		]
	].
]
