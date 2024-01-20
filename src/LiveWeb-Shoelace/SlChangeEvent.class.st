Class {
	#name : #SlChangeEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #serialization }
SlChangeEvent class >> eventFields [ 
	^ { #value -> 'e.target.value' }
]

{ #category : #accessing }
SlChangeEvent class >> type [ 
 ^ 'sl-change'
]

{ #category : #evaluating }
SlChangeEvent >> value [ 
 ^ self at: #value

]
