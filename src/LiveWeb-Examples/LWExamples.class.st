"
I am the main class to start ZnServer with the examples.

Use #start to start the examples on 8080, or #startOn: to set the port.
"
Class {
	#name : #LWExamples,
	#superclass : #Object,
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWExamples class >> start [ 
  ^ self startOn: 8080

]

{ #category : #public }
LWExamples class >> startOn: aPort [
	| server |
	server := ZnServer startOn: 8080.
	server delegate map: #__liveweb to: LWPageConnection.
	server delegate map: #example to: [ :req | LWExamplePage value: req ].
   ^ server
]
