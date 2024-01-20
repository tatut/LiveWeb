Class {
	#name : #SlCheckboxEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #serialization }
SlCheckboxEvent class >> eventFields [ 
	^ { #checked -> 'e.target.checked' }
]

{ #category : #accessing }
SlCheckboxEvent class >> type [ 
^'sl-change'
]

{ #category : #accessing }
SlCheckboxEvent >> checked [ 
 ^ self at: 'checked'

]
