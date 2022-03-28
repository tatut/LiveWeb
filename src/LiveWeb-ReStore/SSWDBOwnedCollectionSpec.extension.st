Extension { #name : #SSWDBOwnedCollectionSpec }

{ #category : #'*LiveWeb-ReStore' }
SSWDBOwnedCollectionSpec >> asLWEditFormComponent: form accessor: anObject [
	^ LWCollectionEditor new 
		 form: form;
		 entityClass: self targetClass;
		 yourself
]
