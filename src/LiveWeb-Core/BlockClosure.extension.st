Extension { #name : #BlockClosure }

{ #category : #'*LiveWeb-Core' }
BlockClosure >> asLWComponent [
	^ LWBlockContainer new block: self
]
