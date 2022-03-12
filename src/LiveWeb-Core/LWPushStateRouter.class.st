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
	id := aDictionary at: #id.
	route := (routes detect: [ :r | r id = id ]).
	^ route stateClass new fromPushStateJSON: aDictionary; yourself
]

{ #category : #initialization }
LWPushStateRouter >> initialize [ 
	routes := OrderedCollection new.
]

{ #category : #'instance creation' }
LWPushStateRouter >> match: aZnUri [
	"Parse state from route. Answer with the parsed state."
	| segments |
	segments := aZnUri segments.
	routes do: [ :r |
		| match |
		match := r match: segments.
		match ifNotNil: [ ^ match ]
	].
	^ nil
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
