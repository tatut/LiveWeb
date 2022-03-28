Extension { #name : #SSWDBStringWithInfo }

{ #category : #'*LiveWeb-ReStore' }
SSWDBStringWithInfo >> asLWEditFormComponent: form accessor: accessor [
	^ LWStringEditor new form: form; maxLength: self fieldSize 
]
