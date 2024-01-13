Class {
	#name : #LWWordleGuess,
	#superclass : #LWStyledComponent,
	#instVars : [
		'word',
		'guess',
		'committed'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'instance creation' }
LWWordleGuess >> backspace [ 
	guess isEmpty ifTrue: [ ^ nil ]. "not empty, do nothing"
	guess := guess allButLast.
	self changed
]

{ #category : #'instance creation' }
LWWordleGuess >> enter [ 
  committed := true.
  self changed.
]

{ #category : #accessing }
LWWordleGuess >> guess [ 
  ^ guess

]

{ #category : #'as yet unclassified' }
LWWordleGuess >> invalid [
	"send flash patch"
	ctx send: #H for: id  with: #invalid.
]

{ #category : #rendering }
LWWordleGuess >> renderOn: h [
	h div: { self style wordleGuess }
		with: [ 
			1 to: 5 do: [ :i | 
				| ch inWord inPosition cls |
				ch := guess at: i ifAbsent: Character space.
				inWord := committed & (word includes: ch).
				inPosition := committed & ((word at: i) = ch).
				cls := String streamContents: [ :c |
					inPosition ifTrue: [ c nextPutAll: 'in-position ' ].
					inWord ifTrue: [ c nextPutAll: 'in-word' ] ]. 
				h div: { (self style wordleGuessCharacter: inPosition word: inWord), (#class -> cls) }
				  with: ch.
			]
	 	]
]

{ #category : #'accessing - structure variables' }
LWWordleGuess >> type: ch [
	guess size = 5 ifTrue: [ ^ nil ]. "already 5 chars"
	guess := guess,ch asString.
	self changed.
]

{ #category : #accessing }
LWWordleGuess >> word: aWord [
  "initialize guess with word"
  word := aWord.
  guess := ''.
  committed := false.
]
