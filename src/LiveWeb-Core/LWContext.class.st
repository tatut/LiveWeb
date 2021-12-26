Class {
	#name : #LWContext,
	#superclass : #Object,
	#instVars : [
		'nextId',
		'changeListeners',
		'callbacks',
		'callbackIdsByComponent'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWContext >> callbackFor: id [
	^ callbacks at: id ifAbsent: nil
]

{ #category : #cleaning }
LWContext >> cleanup: component [ 
	"do state cleanup for component before rerender"
	| callbackIds |
	callbackIds := callbackIdsByComponent removeKey: component id ifAbsent: #().
	callbackIds do: [ :id | callbacks removeKey: id ]
	
]

{ #category : #'as yet unclassified' }
LWContext >> componentChanged: component [
	"notify that some component in the tree has changed and needs rerender"
	changeListeners do: [ :c | c value: component ]
]

{ #category : #initialization }
LWContext >> initialize [
	nextId := 0.
]

{ #category : #'as yet unclassified' }
LWContext >> listenToChanges: aListenerBlock [
	"Add a change listener to this context.
	The listener will be called with the component that has changed.
	Returns a block that will remove the listener."
	changeListeners ifNil: [ changeListeners := IdentitySet new ].
	changeListeners add: aListenerBlock.
	^ [ changeListeners remove: aListenerBlock ]
]

{ #category : #accessing }
LWContext >> nextComponentId [
	| id |
	id := nextId.
	nextId := nextId + 1.
	^ id
]

{ #category : #registering }
LWContext >> registerCallback: aBlock for: component [
   "register callback, returns id number of callback"
	| id |
	id := self nextComponentId .
	callbacks ifNil: [ 
		callbacks := Dictionary new. 
		callbackIdsByComponent := Dictionary new.
		].
	callbacks at: id put: aBlock.
	callbackIdsByComponent at: component id update: [ :ids | ids add: id; yourself ] initial: [Bag with: id].
	^ id
]

{ #category : #testing }
LWContext >> used [ 
	"has this context been used to generate any live components or callbacks?"
	^ nextId > 0
]
