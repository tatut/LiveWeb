Extension { #name : #Object }

{ #category : #'*LiveWeb-ReStore' }
Object >> asLWEditFormComponent: entity [
	| cls c |
	cls := Smalltalk classNamed: 'LW', entity class asString, 'Editor'.
	cls ifNil: [ Error signal: 'No editor component for type ', self class asString ].
	c := cls new.
	c entity: entity.
	^ c
	
]
