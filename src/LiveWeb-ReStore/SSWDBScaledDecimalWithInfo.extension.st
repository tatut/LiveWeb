Extension { #name : #SSWDBScaledDecimalWithInfo }

{ #category : #'*LiveWeb-ReStore' }
SSWDBScaledDecimalWithInfo >> asLWEditFormComponent: form accessor: accessor [
	^ LWScaledDecimalEditor new
		 scale: self scale;
		 form: form; 
		 accessor: accessor;
		 yourself 
]
