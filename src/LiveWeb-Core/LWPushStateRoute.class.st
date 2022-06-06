"
I am a route definition in a push state router.
I can match against an input route and construct a push state object.

"
Class {
	#name : #LWPushStateRoute,
	#superclass : #Object,
	#instVars : [
		'segments',
		'stateClass'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWPushStateRoute >> fieldSegments [
	"answer with accessors for segments that are fields to extract from the path."
	^ segments select: [ :s | 
		 s isEmpty ifTrue: false ifFalse: [ s first = $: ]]
	  thenCollect: [ :s | s allButFirst asSymbol ]
]

{ #category : #accessing }
LWPushStateRoute >> id [
	"answer with the id of this route"
	^ ('/' join: segments) hash printStringBase: 64
]

{ #category : #accessing }
LWPushStateRoute >> match: inputSegments [
   | match |
  segments size ~= inputSegments size ifTrue: [ ^ nil ].

	match := stateClass new.
	match matchedRoute: self.
	
  segments with: inputSegments do: [ :expected :received |
	  | param |
	  param := expected isEmpty ifTrue: false  ifFalse: [ expected first = $: ]. 
		param ifTrue: [ 
			match perform: (expected allButFirst,':') asSymbol with: received ]
		ifFalse: [ 
			expected ~= received ifTrue: [ ^ nil ] ]
	].
	^ match

]

{ #category : #accessing }
LWPushStateRoute >> segments [

	^ segments
]

{ #category : #accessing }
LWPushStateRoute >> segments: anObject [

	segments := anObject
]

{ #category : #accessing }
LWPushStateRoute >> stateClass [

	^ stateClass
]

{ #category : #accessing }
LWPushStateRoute >> stateClass: anObject [

	stateClass := anObject
]
