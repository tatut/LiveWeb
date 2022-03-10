Class {
	#name : #LWEditForm,
	#superclass : #LWFormComponent,
	#instVars : [
		'entityClass',
		'entity',
		'childComponents',
		'exclude',
		'renderBlock',
		'fieldRenderBlock'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #'as yet unclassified' }
LWEditForm class >> forEntityClass: anEntityClass [
	"Answer with a new LWEditForm instance for the given ReStore entity class. The entity must be set before mounting."
	^ self new entityClass: anEntityClass; yourself
]

{ #category : #accessing }
LWEditForm >> allFieldsConfigure: aConfigurationBlock [
	childComponents do: [ :child | child configure: aConfigurationBlock ]
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

{ #category : #accessing }
LWEditForm >> field: aFieldName [
	"Answer with the component for the given field name."
	^ childComponents detect: [ :c | c accessor = aFieldName ]
]

{ #category : #accessing }
LWEditForm >> field: aFieldName configure: aConfigurationBlock [
	"Set configuration block for the named field"
	(self field: aFieldName) configure: aConfigurationBlock
]

{ #category : #accessing }
LWEditForm >> fieldRenderBlock: aRenderBlock [
	"Set the block that overrides default field rendering wrapper.
	The block receives the HTML renderer to render on and the field to render."
	
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
	
	"If form is dependent, try to read the object now (it's okay if it doesn't exist)"
	self isDependent ifTrue: [ entity := self form read: accessor ].
	
	childComponents := entityClass reStoreDefinition instVarDefinitions 
		reject: [ :d | exclude includes: d key ]
		thenCollect: [ :d | 
		| c |
		c := d value asLWEditFormComponent: self accessor: d key.
		c accessor: d key.
		c ].
	super mount.	

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

{ #category : #accessing }
LWEditForm >> renderBlock: aBlock [
	"Set a render block that overrides normal rendering. 
	 The render block will receive 2 arguments:  
	 - the HTMLRenderer instance to render on
	 - mapping of child components (from accessor to component)
	
	The render block should render all child components."
	renderBlock := aBlock
]

{ #category : #rendering }
LWEditForm >> renderFieldOn: h component: c [
	fieldRenderBlock 
    ifNotNil: [ fieldRenderBlock value: h value: c ]
    ifNil: [ c render: h ]
	
]

{ #category : #rendering }
LWEditForm >> renderOn: h [
	renderBlock
	  ifNil: [
		  self isDependent 
       ifTrue: [ 
        h fieldset: { #class -> #editFormFieldset } with: [ 
			 h legend: (self messages fieldsetCaption: accessor).
	      childComponents do: [ :c | self renderFieldOn: h component: c ]
		  ]
	   ]
      ifFalse: [ 
       h form: { #class -> #editForm } with: [ 
		   childComponents do: [ :c | self renderFieldOn: h component: c ]
     ]]]
    ifNotNil: [ 
			renderBlock 
				value: h 
				value: [ :acc | self renderFieldOn: h component: (self field: acc) ]
		]
	
]

{ #category : #submit }
LWEditForm >> submit [
	"Run any validations and store the entity to the database. 
	If there are any problems, highlights the fields.
	This should also check if there has been other modifications to the entity
	and possibly refresh.
	
	Answers with true if data was saved, false otherwise.
	" 
	"FIXME: validate"
	self ensureEntity store.
	^ true
]

{ #category : #writing }
LWEditForm >> write: aFieldAccessor value: aValue [ 
	| sel |
	sel := (aFieldAccessor , ':') asSymbol.
	self ensureEntity perform: sel with: aValue
]
