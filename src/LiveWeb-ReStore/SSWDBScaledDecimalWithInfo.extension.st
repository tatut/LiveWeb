Extension { #name : #SSWDBScaledDecimalWithInfo }

{ #category : #'*LiveWeb-ReStore' }
SSWDBScaledDecimalWithInfo >> asLWEditFormComponent: form accessor: accessor [
	^ LWNumericEditor new
		 form: form; 
		 accessor: accessor;
		 yourself 
]
