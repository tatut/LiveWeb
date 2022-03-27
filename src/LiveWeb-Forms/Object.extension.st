Extension { #name : #Object }

{ #category : #'*LiveWeb-Forms' }
Object class >> asLWEditFormComponent: form accessor: accessor [
	"Try to create an editor component for any type by common editor name pattern 'LW<class>Editor'."
	| cls c |
	cls := Smalltalk classNamed: 'LW', self name, 'Editor'.
	cls ifNil: [ Error signal: 'No editor component for type ', self name ].
	c := cls new.
	c form: form.
	^ c
	
]
