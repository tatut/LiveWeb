"
I am a base class for components that build from Bulma components.
Instead of the raw HTML rendering #renderOn:, subclasses will override
the method #view: which is given an LWBulma builder instance.

This makes it easy to build components in a fluid way without needing 
raw HTML.
"
Class {
	#name : #LWBulmaComponent,
	#superclass : #LWComponent,
	#instVars : [
		'root'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #'component lifecycle' }
LWBulmaComponent >> mount [ 
  root := self view: LWBulma new
]

{ #category : #accessing }
LWBulmaComponent >> view: anLWBulma [ 
	"Build the root view of this component using the given builder."
	self subclassResponsibility 
]
