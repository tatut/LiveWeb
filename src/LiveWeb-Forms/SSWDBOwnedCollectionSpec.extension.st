Extension { #name : #SSWDBOwnedCollectionSpec }

{ #category : #'*LiveWeb-Forms' }
SSWDBOwnedCollectionSpec >> asLWEditFormComponent: form accessor: anObject [
	^ LWCollectionEditor new 
		 form: form;
		 entityClass: self targetClass;
		 yourself
]
