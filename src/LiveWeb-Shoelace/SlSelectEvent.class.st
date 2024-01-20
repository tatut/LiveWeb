Class {
	#name : #SlSelectEvent,
	#superclass : #LWCustomEvent,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #serialization }
SlSelectEvent class >> eventFields [ 
 ^ { #selectedItemValue -> 'e.detail.item.getAttribute("value")' }

]

{ #category : #accessing }
SlSelectEvent class >> type [ 
 ^ 'sl-select'

]

{ #category : #'as yet unclassified' }
SlSelectEvent >> selectedItemValue [ 
 ^ self at: #selectedItemValue 

]
