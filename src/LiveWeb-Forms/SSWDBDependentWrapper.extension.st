Extension { #name : #SSWDBDependentWrapper }

{ #category : #'*LiveWeb-Forms' }
SSWDBDependentWrapper >> asLWEditFormComponent: form accessor: accessor [
	^ LWEditForm new 
		  entityClass: self dependentObject;
		  form: form; 
		  accessor: accessor;
		  yourself
]
