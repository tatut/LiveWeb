"
I am an LWPage that includes Bulma CSS in the header.
"
Class {
	#name : #LWBulmaPage,
	#superclass : #LWPage,
	#category : #'LiveWeb-Bulma'
}

{ #category : #'as yet unclassified' }
LWBulmaPage >> bulmaURL [ 
 ^ 'https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css'

]

{ #category : #'API - accessing' }
LWBulmaPage >> head: _args [
 ^ LWBlockContainer new block: [ :h | 
	  h link: { #rel -> 'stylesheet'. #href -> self bulmaURL };
	    meta: { #name -> 'viewport'. #content -> 'width=device-width, initial-scale=1' }
	  ]
]
