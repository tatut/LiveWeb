Class {
	#name : #LWContext,
	#superclass : #Object,
	#instVars : [
		'nextId',
		'connection',
		'callbacks',
		'callbackIdsByComponent',
		'components'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWContext >> callbackFor: id [
	^ callbacks at: id ifAbsent: nil
]

{ #category : #cleaning }
LWContext >> cleanup: component [ 
	"do state cleanup for component before rerender"
	component childrenRecursive do: [ :c | 
		| callbackIds |
		c unmount.
		callbackIds := callbackIdsByComponent removeKey: component id ifAbsent: #().
		callbackIds do: [ :id | callbacks removeKey: id ]
	].
]

{ #category : #'as yet unclassified' }
LWContext >> component: parentComponent childAdded: newChildComponent at: index [
	"notify that a child was added to an already mounted parent component.
	Will mount and render the child and send it to the client, adding it
	to the page DOM at the right position."
	connection component: parentComponent childAdded: newChildComponent at: index.
]

{ #category : #'as yet unclassified' }
LWContext >> componentChanged: component [
	"notify that some component in the tree has changed and needs rerender"
	connection 
		ifNil: [ 
			"PENDING: handle separate cases: page not YET connected and connection going away"
			component unmount ]
		ifNotNil: [ 	connection componentChanged: component ]
]

{ #category : #accessing }
LWContext >> components [

	^ components
]

{ #category : #accessing }
LWContext >> connection [

	^ connection
]

{ #category : #accessing }
LWContext >> connection: anObject [

	connection := anObject
]

{ #category : #initialization }
LWContext >> initialize [
	nextId := 0.
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

{ #category : #registering }
LWContext >> registerComponent: anLWComponent [
   "register new component in this context, returns id number of component"
	| id |
	id := self nextComponentId .
	components ifNil: [ components := Dictionary new. ].
	components at: id put: anLWComponent.
	^ id
]

{ #category : #testing }
LWContext >> used [ 
	"has this context been used to generate any live components or callbacks?"
	^ nextId > 0
]
