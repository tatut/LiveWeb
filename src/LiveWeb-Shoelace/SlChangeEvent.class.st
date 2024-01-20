Class {
	#name : #SlChangeEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlChangeEvent class >> eventFields [ 
	^ #( 'value' )
]

{ #category : #accessing }
SlChangeEvent class >> type [ 
 ^ 'sl-change'
]

{ #category : #evaluating }
SlChangeEvent >> value [ 
 ^ self at: #value

]
