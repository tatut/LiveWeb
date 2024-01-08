"
I am a higher level UI presenter. Use me to describe views with higher level
components like panels, tables and buttons, instead of raw HTML.

I am configured with an instance of HTMLRenderer and LWStylesheetProvider that I use to create the actual HTML producing components.

"
Class {
	#name : #LWPresenter,
	#superclass : #Object,
	#instVars : [
		'htmlRenderer',
		'style'
	],
	#category : #'LiveWeb-Presenter'
}

{ #category : #'as yet unclassified' }
LWPresenter >> twoColumnListing [ 
	"Create an empty 2 column list component."
	^ LWTwoColumnListing new style: style; yourself 
]

{ #category : #'as yet unclassified' }
LWPresenter >> twoColumnListing: mappings [  
	"Create a 2 column listing that contains the given mappings."
	| lst |
	lst := self twoColumnListing.
	mappings do: [ :m | lst left: m key right: m value ].
	^ lst
]
