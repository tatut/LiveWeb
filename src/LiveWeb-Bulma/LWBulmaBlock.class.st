Class {
	#name : #LWBulmaBlock,
	#superclass : #LWContainer,
	#category : #'LiveWeb-Bulma'
}

{ #category : #initialization }
LWBulmaBlock >> initialize [ 
  super initialize. 
  containerElement := #div.
  containerAttributes := { #class -> 'block' }
]
