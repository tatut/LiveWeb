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

{ #category : #'as yet unclassified' }
LWCustomEvent class >> eventJS [ 
 "Build JS to create the event object in the browser side, using the event 'e'.
  For example: ^ '{''value'': e.target.value}'
 "
 self subclassResponsibility. 
]

{ #category : #'instance creation' }
LWCustomEvent class >> fromDictionary: d [
 | e |
 e := self new.
 self eventFields do: [ :f |
	e at: f put: (d at: f)
 ].
 ^ e
]

{ #category : #accessing }
LWCustomEvent class >> type [ 
 "Return the JS event type to add listeners for. For example 'change'" 
 self subclassResponsibility 
]
