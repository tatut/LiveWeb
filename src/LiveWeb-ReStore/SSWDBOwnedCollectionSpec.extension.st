Extension { #name : #SSWDBOwnedCollectionSpec }

{ #category : #'*LiveWeb-ReStore' }
SSWDBOwnedCollectionSpec >> asLWEditFormComponent: form accessor: anObject [
	^ LWBaseEditor new form: form; yourself
]
