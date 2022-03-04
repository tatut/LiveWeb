Extension { #name : #SSWDBStringWithInfo }

{ #category : #'*LiveWeb-ReStore' }
SSWDBStringWithInfo >> asLWEditFormComponent: entity [
	^ LWStringEditor new entity: entity; maxLength: self fieldSize 
]
