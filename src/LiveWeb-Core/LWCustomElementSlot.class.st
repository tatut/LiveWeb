Class {
	#name : #LWCustomElementSlot,
	#superclass : #LWSingleContainer,
	#instVars : [
		'slot'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #initialization }
LWCustomElementSlot >> initialize [ 
 super initialize.
 containerElement := #div.
]

{ #category : #accessing }
LWCustomElementSlot >> slot: slotName [
  containerAttributes := { #slot -> slotName }.

]
