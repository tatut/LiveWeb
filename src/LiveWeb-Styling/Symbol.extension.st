Extension { #name : #Symbol }

{ #category : #'*LiveWeb-Styling' }
Symbol >> asCSSPropertyName [
	^ String streamContents: [ :out |
		self do: [ :ch |
			ch isUppercase 	
				ifTrue: [ out nextPut: $-; nextPut: ch lowercase ]
				ifFalse: [ out nextPut: ch ]
		]	
	]
]

{ #category : #'*LiveWeb-Styling' }
Symbol >> asCSSPropertyValue [
	^ self asString
]
