Class {
	#name : #LWWordleKeyboard,
	#superclass : #LWStyledComponent,
	#instVars : [
		'game',
		'disabledKeys',
		'keyboardListener'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWWordleKeyboard >> children [ 
	^ ReadStream on: { keyboardListener }
]

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
  keyboardListener := LWWindowListener 
		on: #keyup call: (Js call: [ :k | self onKeyUp: k ] with: 'event.keyCode') 

]

{ #category : #'as yet unclassified' }
LWWordleKeyboard >> onKeyUp: key [
	key = 13 ifTrue: [ ^ game enter ].
	key = 8 ifTrue: [ ^ game backspace ].
	key asCharacter isLetter ifTrue: [ ^ game type: (key asCharacter asLowercase) ]
]

{ #category : #rendering }
LWWordleKeyboard >> renderOn: h [
  "render a keyboard in three rows, pressing key calls game methods to type"
	h div: { self style wordleKeyboard } with: [ 
		keyboardListener render: h.
		#('qwertyuiop' 'asdfghjkl' 'zxcvbnm') do: [ :row |
			h div: { self style wordleKeyboardRow } with: [ 
				| last |
				last := (row at: 1) = $z.
				last ifTrue: [ h button: { #onclick -> [ game enter ] } with: 'ENTER' ].
				row do: [ :ch |
					h div: { self style wordleKeyboardKey: (disabledKeys includes: ch). #onclick -> [ game type: ch ].
					         'data-disabled' -> (disabledKeys includes: ch).
						      'data-key' -> ch }
						with: ch 
				].
				last ifTrue: [ h button: { #onclick -> [ game backspace ] } with: 'BACKSPACE' ]
			]
		]
	].
]
