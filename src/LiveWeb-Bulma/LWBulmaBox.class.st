Class {
	#name : #LWBulmaBox,
	#superclass : #LWContainer,
	#category : #'LiveWeb-Bulma'
}

{ #category : #initialization }
LWBulmaBox >> initialize [ 
  super initialize.
  containerElement := #div.
  containerAttributes := { #class -> 'box' }
]
