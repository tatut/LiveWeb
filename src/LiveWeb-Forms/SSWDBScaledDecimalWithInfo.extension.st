Extension { #name : #SSWDBScaledDecimalWithInfo }

{ #category : #'*LiveWeb-Forms' }
SSWDBScaledDecimalWithInfo >> asLWEditFormComponent: form accessor: accessor [
	^ LWScaledDecimalEditor new
		 scale: self scale;
		 form: form; 
		 accessor: accessor;
		 yourself 
]
