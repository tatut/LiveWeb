Class {
	#name : #LWEditForm,
	#superclass : #LWFormComponent,
	#instVars : [
		'entityClass',
		'entity',
		'childComponents',
		'exclude'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #'as yet unclassified' }
LWEditForm class >> forEntityClass: anEntityClass [
	"Answer with a new LWEditForm instance for the given ReStore entity class. The entity must be set before mounting."
	^ self new entityClass: anEntityClass; yourself
]

{ #category : #accessing }
LWEditForm >> childComponents: anObject [

	childComponents := anObject
]

{ #category : #accessing }
LWEditForm >> children [
	^ReadStream on: childComponents 
]

{ #category : #'as yet unclassified' }
LWEditForm >> ensureEntity [
	"Answer with the entity for this editor, creating it if necessary."
	entity ifNil: [
		self isDependent 
		ifTrue: [ 
			entity := form read: accessor.
			entity ifNil: [  
				entity := entityClass new.
				form write: accessor value: entity.
			]]
		ifFalse: [ entity := entityClass new. ]].
	^ entity
]

{ #category : #accessing }
LWEditForm >> entity [
	^ entity
]

{ #category : #accessing }
LWEditForm >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
LWEditForm >> entityClass: anEntityClass [
	entityClass := anEntityClass 
]

{ #category : #accessing }
LWEditForm >> exclude: aFieldName [
	"don't include the given field name when rendering"
	exclude add: aFieldName 
]

{ #category : #initialization }
LWEditForm >> initialize [ 
	super initialize.
	childComponents := {}.
	exclude := Set new.

]

{ #category : #testing }
LWEditForm >> isDependent [ 
	"Answer with true if this form is a dependent form inside a parent form, false otherwise."
	^ form isNil not
]

{ #category : #'component lifecycle' }
LWEditForm >> mount [
	"Create edit components for all children in ReStore definition."
	childComponents := entityClass reStoreDefinition instVarDefinitions 
		reject: [ :d | exclude includes: d key ]
		thenCollect: [ :d | 
		| c |
		c := d value asLWEditFormComponent: self accessor: d key.
		c accessor: d key.
		c ]
]

{ #category : #'meta-object-protocol' }
LWEditForm >> read: aFieldAccessor [ 
	"Answer with value of the entity for the accessor. If entity hasn't doesn't exist defaults to nil."
	^ self read: aFieldAccessor ifEntityNil: nil
]

{ #category : #'meta-object-protocol' }
LWEditForm >> read: aFieldAccessor ifEntityNil: aDefaultValue [
	"Answer with value of the entity for the accessor. If entity doesn't exist defaults to aDefaultValue."
	entity ifNil: [ ^ aDefaultValue ].
	^ entity perform: aFieldAccessor 
]

{ #category : #'meta-object-protocol' }
LWEditForm >> read: aFieldAccessor withDefault: aDefaultValue [
	"Answer with value of the entity for the accessor. If entity doesn't exist or has nil value for the field, defaults to aDefaultValue."
	| v |
	v := self read: aFieldAccessor ifEntityNil: aDefaultValue.
	v ifNil: [ ^ aDefaultValue ].
	^ v
]

{ #category : #'meta-object-protocol' }
LWEditForm >> readEnsuring: aFieldAccessor [ 
	"Answer with value of the entity for the accessor. If entity doesn't exist, it will be created."
	^ self read: aFieldAccessor ifEntityNil: nil
]

{ #category : #rendering }
LWEditForm >> renderOn: h [
	self isDependent 
    ifTrue: [ 
      h fieldset: { #class -> #editFormFieldset } with: [ 
	     childComponents do: [ :c | c render: h ]
		 ]
	  ]
    ifFalse: [ 
     h form: { #class -> #editForm } with: [ 
		childComponents do: [ :c | c render: h ]
    ]
  ]
]

{ #category : #writing }
LWEditForm >> write: aFieldAccessor value: aValue [ 
	| sel |
	sel := (aFieldAccessor , ':') asSymbol.
	self ensureEntity perform: sel with: aValue
]
