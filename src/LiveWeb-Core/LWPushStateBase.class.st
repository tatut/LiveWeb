"
I am the abstract base class for page state parsed from a push state route.
I can turn the state back into a route (for sending navigation to browser)
and JSON state.

Subclasses must have instance variables with accessors for all the path 
segments. For example the path '/customers/:customerId/orders/:orderId' 
must have customerId and orderId instance variables with the regular getter
and setter patterns. 
"
Class {
	#name : #LWPushStateBase,
	#superclass : #Object,
	#instVars : [
		'matchedRoute'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #converting }
LWPushStateBase >> asPushStateJSON [ 
	"return STONable push state"
	^ (matchedRoute fieldSegments 
	    collect: [ :s | s -> (self perform: s) ]) asDictionary
		at: '_route' put: matchedRoute id; yourself

]

{ #category : #converting }
LWPushStateBase >> asRoute [
	"Answer with the route path"
	^ String streamContents: [ :out |
		matchedRoute segments do: [ :seg |
			out << $/.
			seg first = $:
			ifTrue: [ 
				out << (self perform: (seg allButFirst asSymbol)) asString ]
			ifFalse: [ 
				out << seg ]	
		]
	]
]

{ #category : #converting }
LWPushStateBase >> fromPushStateJSON: aDictionary [
	"read fields from JSON dictionary"
	matchedRoute fieldSegments do: [ :s |
		| setter |
		setter := (s,':') asSymbol.
		self perform: setter with: (aDictionary at: s)]

]

{ #category : #accessing }
LWPushStateBase >> matchedRoute [

	^ matchedRoute
]

{ #category : #accessing }
LWPushStateBase >> matchedRoute: anObject [

	matchedRoute := anObject
]
