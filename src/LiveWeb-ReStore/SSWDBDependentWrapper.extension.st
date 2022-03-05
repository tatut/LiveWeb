Extension { #name : #SSWDBDependentWrapper }

{ #category : #'*LiveWeb-ReStore' }
SSWDBDependentWrapper >> asLWEditFormComponent: form accessor: accessor [
	| dependentEntity |
	dependentEntity := form read: accessor. 
	dependentEntity inspect.
	^ LWDependentEditor new dependent: self; form: form; yourself
]
