Class {
	#name : #LWCrudPage,
	#superclass : #LWStyledPage,
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWCrudPage class >> value: req [ 
	^ self new value: req 
]

{ #category : #accessing }
LWCrudPage >> body: _args [
	^ LWSingleContainer new child: (LWCrudExample new entity: (self entityToEdit: (self initialPushState))) 
]

{ #category : #'as yet unclassified' }
LWCrudPage >> entityToEdit: state [
	| entityClass entityId |
	entityClass := { #customer -> Customer } asDictionary at: (state at: #table).
	entityId := state at: #id.
	^ entityId 
		ifNil: [ entityClass new ] 
		ifNotNil: [ entityClass storedInstances detect: [ :e | e _id = entityId ] ]
]

{ #category : #'push state handling' }
LWCrudPage >> initialPushState [ 
	| seg table entityId |
	seg := args uri segments allButFirst.
	(seg last matchesRegex: '\d+')
	  ifTrue: [ table := seg first. entityId := seg last.  ]
	  ifFalse: [ table := seg last. entityId := nil ].
  ^ { #table -> table . #id -> entityId } asDictionary
	 
]

{ #category : #'as yet unclassified' }
LWCrudPage >> prepareCtx [ 
	super prepareCtx .
	ctx at: #formMessages put: LWFormMessages new. "could use user's selected language here"
]

{ #category : #'as yet unclassified' }
LWCrudPage >> stylesheetProvider [ 
	^ LWStylesheetProvider provider: LWExampleStyles 
]

{ #category : #'push state handling' }
LWCrudPage >> usePushState [ 
	^ true

]
