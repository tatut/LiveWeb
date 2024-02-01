"
I am the main class to start ZnServer with the examples.

Use #start to start the examples on 8080, or #startOn: to set the port.
"
Class {
	#name : #LWExamples,
	#superclass : #Object,
	#classVars : [
		'Server'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #private }
LWExamples class >> browse [ 
	LibC system: 'open http://localhost:', Server port asString, '/examples/clock'

]

{ #category : #accessing }
LWExamples class >> server [ 
  ^ Server
]

{ #category : #accessing }
LWExamples class >> start [ 
  ^ self startOn: 8080

]

{ #category : #public }
LWExamples class >> startOn: aPort [
	Server := ZnServer startOn: aPort.
	Server delegate map: #__liveweb to: LWPageConnection.
	Server delegate map: #examples to: [ :req | LWExamplePage value: req ].
   ^ Server
]

{ #category : #accessing }
LWExamples class >> stop [ 
  Server stop.
  Server := nil.
  ^ self
]
