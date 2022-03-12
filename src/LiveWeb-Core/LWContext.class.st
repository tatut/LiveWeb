"
I provide a context for the client's instance of a component tree.
I keep track of all the components and their ids and callbacks.

I also provide user objects that can be used to provide additional information to components. 
"
Class {
	#name : #LWContext,
	#superclass : #Object,
	#instVars : [
		'nextId',
		'connection',
		'callbacks',
		'callbackIdsByComponent',
		'components',
		'user',
		'sendQueue',
		'page'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWContext >> at: aKey [
	"Get the user object at key."
	^ user at: aKey
]

{ #category : #accessing }
LWContext >> at: aKey put: userObject [
	"Put a user object into context."
	user at: aKey put: userObject
]

{ #category : #accessing }
LWContext >> callbackFor: id [
	^ callbacks at: id ifAbsent: nil
]

{ #category : #cleaning }
LWContext >> cleanup: component [ 
	"do state cleanup for component before rerender"
	[ "cleanup all children before parents"
	component childrenRecursive do:  [ :c | self doCleanupComponent: c ].
	self doCleanupComponent: component.
   ] 
	on: Error 
	do: [ :sig |
			"PENDING: what to do here? this is likely a bug in some component impl, 
			we can just show it here so developer can take care of it"
			LWLogEvent warn: 'Cleanup exception for ', component printString, ' signal: ', sig printString.
			]
]

{ #category : #'component lifecycle' }
LWContext >> component: parentComponent childAdded: newChildComponent at: index [
	"notify that a child was added to an already mounted parent component.
	Will mount and render the child and send it to the client, adding it
	to the page DOM at the right position."
	connection component: parentComponent childAdded: newChildComponent at: index.
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
	connection := anObject.
	sendQueue ifNotNil: [ 
		connection send: sendQueue asArray.
		sendQueue := nil.
  ]
]

{ #category : #'as yet unclassified' }
LWContext >> connectionClosed [
	connection := nil.
	components valuesDo: [ :c | self cleanup: c ]. 
	components := nil.
]

{ #category : #'as yet unclassified' }
LWContext >> doCleanupComponent: c [
	| callbackIds |
	c isMounted ifTrue: [ 
		c doUnmount.
		callbackIds := callbackIdsByComponent removeKey: c id ifAbsent: #().
		callbackIds do: [ :id | callbacks removeKey: id ]
	]
]

{ #category : #'as yet unclassified' }
LWContext >> go: aPushState [
	"Send push state navigation to client.
	The push state must be a LWPushStateBase subclass or compatible that
	knows how to create the route path and JSON state."
	self send: 'E' for: '' with: ('_lw.pushState(<1s>, <2s>)'
		expandMacrosWith: (STON toJsonString: aPushState asRoute)
		 with: (STON toJsonString: aPushState asPushStateJSON)).
		
	"Also notify page that push state has changed (so it can update any components)"
	page pushStateChanged: aPushState.
]

{ #category : #'as yet unclassified' }
LWContext >> go: path with: state [
	"Send push state navigation to client with given state (must be convertable to JSON).
	This will only work if page is using push state. 
	State should contain everything needed to reconstitute the parameters of the 
	page, as they will be sent back by the browser when user navigates (eg. back/forward button)."
	self send: 'E' for: '' with: ('_lw.pushState(<1s>, <2s>)'
		expandMacrosWith: (STON toJsonString: state)
		 with: (STON toJsonString: path)).
		
	"Also notify page that push state has changed (so it can update any components)"
	page pushStateChanged: state.
]

{ #category : #'as yet unclassified' }
LWContext >> goJS: aPushState [
	"Return JS callback that navigates with push state when invoked.
	The callback will prevent default click handler so it can be used in HTML anchor links."
	^ LWScriptCallback new 
			callback: [ self go: aPushState ]; 
			jsParams: #(); 
			preventDefault: true.
			
]

{ #category : #'as yet unclassified' }
LWContext >> goJS: path with: state [
	"Return JS callback that navigates with push state using (go:with:).
	The callback will prevent default click handler so it can be used in HTML anchor links."
	^ LWScriptCallback new 
			callback: [ self go: path with: state ]; 
			jsParams: #(); 
			preventDefault: true.
			
]

{ #category : #initialization }
LWContext >> initialize [
	nextId := 0.
	user := Dictionary new.
]

{ #category : #accessing }
LWContext >> nextComponentId [
	| id |
	id := nextId.
	nextId := nextId + 1.
	^ id
]

{ #category : #accessing }
LWContext >> page [ 
	"return the page I am the context for"
	^ page
]

{ #category : #accessing }
LWContext >> page: aPage [
	"set the page I am the context for"
	page := aPage
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

{ #category : #'component lifecycle' }
LWContext >> rerenderComponent: component [
	"notify that some component in the tree has changed and needs rerender"
	connection 
		ifNil: [ 
			"PENDING: handle separate cases: page not YET connected and connection going away"
			component unmount ]
		ifNotNil: [ 	connection rerenderComponent: component ]
]

{ #category : #'as yet unclassified' }
LWContext >> send: patchType for: componentId with: content [
	"Send patch for component with content.
	If connection is not yet established, the send will be queued."
	connection
	  ifNil: [
			sendQueue ifNil: [ sendQueue := OrderedCollection new ].
			sendQueue add: { componentId asString . patchType asString . content }
		]
	  ifNotNil: [ connection send: { { componentId asString. patchType asString. content } } ] 
]

{ #category : #testing }
LWContext >> used [ 
	"has this context been used to generate any live components or callbacks?"
	^ nextId > 0
]
