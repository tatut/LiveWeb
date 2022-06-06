"
I handle push state routing and transform between route and push state.
I can generate state from a route and vice versa.

"
Class {
	#name : #LWPushStateRouter,
	#superclass : #Object,
	#instVars : [
		'routes'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'instance creation' }
LWPushStateRouter >> fromPushStateJSON: aDictionary [
	"Parse state from JSON received from the browser.
	Matches the route by id."
	| id route |
	id := aDictionary at: #_route.
	route := (routes detect: [ :r | r id = id ]).
	^ route stateClass new 
		 matchedRoute: route;
		 fromPushStateJSON: aDictionary; yourself
]

{ #category : #initialization }
LWPushStateRouter >> initialize [ 
	routes := OrderedCollection new.
]

{ #category : #'instance creation' }
LWPushStateRouter >> match: aZnUri [
	"Parse state from route. Answer with the parsed state."
	| segments |
	segments := aZnUri segments 
	  ifNil: {''} 
	  ifNotNil: [ :segs | segs select: [:s | s size > 0 ]].
	routes do: [ :r |
		| match |
		match := r match: segments.
		match ifNotNil: [ ^ match ]
	].
	^ nil
]

{ #category : #'instance creation' }
LWPushStateRouter >> matchState: aPushState [
	"Create push state that matches the given push state template.
	Considers routes that have the same state class.
	If there are multiple candidates, considers the set of non-nil instance variables."
	| candidates setVariables route |
	candidates := routes select: [ :r | r stateClass = aPushState class ].
	candidates isEmpty ifTrue: [ Error signal: 'No matching route for push state template.' ].
	candidates size = 1 ifTrue: [ ^ aPushState copy matchedRoute: candidates first; yourself ].
	
	"we have multiple candidates, need to consider the instance variables"
	setVariables := Set new.
	aPushState class instanceVariables do: [ :v | (v read: aPushState) ifNotNil: [ setVariables add: v name ] ].
 	route := candidates 
		detect: [ :r | r fieldSegments asSet = setVariables] 
		ifNone: [ Error signal: 'No matching route candidate for push state template' ].
	^ aPushState copy matchedRoute: route; yourself
]

{ #category : #'as yet unclassified' }
LWPushStateRouter >> route: aPathString as: aStateClass [
	routes add: (LWPushStateRoute new 
		segments: (self routeSegments: aPathString);
		stateClass: aStateClass; 
		yourself)
]

{ #category : #'as yet unclassified' }
LWPushStateRouter >> routeSegments: aRouteString [
   | segments |
	segments := aRouteString splitOn: $/.
	segments first = '' ifTrue: [ segments := segments allButFirst ].	
	^ segments

]
