Extension { #name : #String }

{ #category : #'*LiveWeb-Core' }
String >> asLWComponent [ 
 ^ LWBlockContainer new block: [ :h | h span: self ]

]
