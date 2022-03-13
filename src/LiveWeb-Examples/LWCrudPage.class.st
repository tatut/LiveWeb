"
I am an example CRUD page. I can edit and list entities.
"
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
	| state |
	state := self initialPushState.
	^ LWSingleContainer new child: (LWCrudExample new entity: state entityToEdit) 
]

{ #category : #'as yet unclassified' }
LWCrudPage >> entityToEdit: state [
	| entityClass entityId |
	entityClass := { 
		#customer -> Customer. 
		#address -> Address. 
		#order -> CustomerOrder} asDictionary at: (state at: #table).
	entityId := state at: #id.
	^ entityId 
		ifNil: [ LWLogEvent info: 'create new'. entityClass new ] 
		ifNotNil: [ (entityClass storedInstances detect: [ :e | e _id = entityId ]) refresh; yourself ]
]

{ #category : #'push state handling' }
LWCrudPage >> initialPushState [ 
	^ LWCrudRouter new match: args uri.
	 
]

{ #category : #'as yet unclassified' }
LWCrudPage >> prepareCtx [ 
	super prepareCtx .
	ctx at: #formMessages put: LWFormMessages new. "could use user's selected language here"
]

{ #category : #'push state handling' }
LWCrudPage >> pushStateChanged: newState [
 	| state |
	state := LWCrudRouter new fromPushStateJSON: newState.
	body child: (LWCrudExample new entity: state entityToEdit)
]

{ #category : #'as yet unclassified' }
LWCrudPage >> stylesheetProvider [ 
	^ LWStylesheetProvider provider: LWExampleStyles 
]

{ #category : #'push state handling' }
LWCrudPage >> usePushState [ 
	^ true

]
