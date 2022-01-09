Extension { #name : #BlockClosure }

{ #category : #'*LiveWeb-Core' }
BlockClosure >> asLWComponent [
	^ LWBlockContainer new block: self
]

{ #category : #'*LiveWeb-Core' }
BlockClosure >> asLWScriptCallback [
	^ LWScriptCallback new callback: self; jsParams: #()
]
