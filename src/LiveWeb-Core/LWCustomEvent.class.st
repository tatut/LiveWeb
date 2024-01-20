"
I am an event type that can be listened to on a LWCustomElement.

Subclass me to specialize the event type and JavaScript objects.
"
Class {
	#name : #LWCustomEvent,
	#superclass : #SmallDictionary,
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWCustomEvent class >> eventFields [ 
	"Return an array of field names in the event. These will be added to self as associations 
	when deserializing an event from JSON.
	
	for example: ^ #( value )
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
