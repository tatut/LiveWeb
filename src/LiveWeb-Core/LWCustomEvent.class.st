"
I am an event type that can be listened to on a LWCustomElement.

Subclass me to specialize the event type and JavaScript objects.
"
Class {
	#name : #LWCustomEvent,
	#superclass : #SmallDictionary,
	#category : #'LiveWeb-Core'
}

{ #category : #serialization }
LWCustomEvent class >> eventFields [ 
	"Return an array of associations mapping instance variables to JS code needed to extract the value from event.
	
	for example: ^ { #value -> 'e.target.value' }
	"
	self subclassResponsibility 
]

{ #category : #'instance creation' }
LWCustomEvent class >> fromArray: arr [
 | e |
 e := self new.
 self eventFields doWithIndex: [ :f :i |
	e at: f key put: (arr at: i)
 ].
 ^ e
]

{ #category : #accessing }
LWCustomEvent class >> type [ 
 "Return the JS event type to add listeners for. For example 'change'" 
 self subclassResponsibility 
]
