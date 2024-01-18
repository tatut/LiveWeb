Class {
	#name : #SlCheckboxEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlCheckboxEvent class >> eventFields [ 
	^ #('checked')
]

{ #category : #'as yet unclassified' }
SlCheckboxEvent class >> eventJS [ 
^'{"checked":e.target.checked}'
]

{ #category : #accessing }
SlCheckboxEvent class >> type [ 
^'sl-change'
]

{ #category : #accessing }
SlCheckboxEvent >> checked [ 
 ^ self at: 'checked'

]
