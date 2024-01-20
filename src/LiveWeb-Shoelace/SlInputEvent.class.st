"
I am a form input event. I provide the current value of the target.
"
Class {
	#name : #SlInputEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #serialization }
SlInputEvent class >> eventFields [ 
 ^ { #value -> 'e.target.value' }
]

{ #category : #accessing }
SlInputEvent class >> type [ 
 ^ 'sl-input'

]

{ #category : #evaluating }
SlInputEvent >> value [ 
 ^ self at: #value

]
