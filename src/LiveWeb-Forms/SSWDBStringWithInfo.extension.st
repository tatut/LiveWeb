Extension { #name : #SSWDBStringWithInfo }

{ #category : #'*LiveWeb-Forms' }
SSWDBStringWithInfo >> asLWEditFormComponent: form accessor: accessor [
	^ LWStringEditor new form: form; maxLength: self fieldSize 
]
