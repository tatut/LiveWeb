Class {
	#name : #SlClickEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #serialization }
SlClickEvent class >> eventFields [ 
 ^ {}

]

{ #category : #accessing }
SlClickEvent class >> type [ 
 ^ 'click'
]
