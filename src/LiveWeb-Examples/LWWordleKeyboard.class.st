Class {
	#name : #LWWordleKeyboard,
	#superclass : #LWStyledComponent,
	#instVars : [
		'game'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWWordleKeyboard >> game: aGame [
 game := aGame
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
					| wrong |
					wrong := false. "check all wrong characters"
					h div: { self style wordleKeyboardKey: false. #onclick -> [ game type: ch ] }
						with: ch 
				].
				last ifTrue: [ h button: { #onclick -> [ game backspace ] } with: 'BACKSPACE' ]
			]
		]
	].
]
