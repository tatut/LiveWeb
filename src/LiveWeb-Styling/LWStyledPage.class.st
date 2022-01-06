"
I am a root page that installs the LWStyleAttributeRenderer to 
the page HTML renderer.
"
Class {
	#name : #LWStyledPage,
	#superclass : #LWPage,
	#category : #'LiveWeb-Styling'
}

{ #category : #'instance creation' }
LWStyledPage >> head: _args [
	| ssp |
	ssp := ctx at: #stylesheetProvider.
	ssp ifNil: [ ^ nil ].
	^ LWStylesheetComponent on: ssp
	
]

{ #category : #rendering }
LWStyledPage >> htmlRenderer: stream [
	| r |
	r := super htmlRenderer: stream.
	r withAttributeRenderer: LWStyleAttributeRenderer new.
	^ r

]

{ #category : #'as yet unclassified' }
LWStyledPage >> prepareCtx [ 
  | ssp |
  ssp := self stylesheetProvider .
  ssp ifNotNil: [ ctx at: #stylesheetProvider put: ssp ]
]

{ #category : #'as yet unclassified' }
LWStyledPage >> stylesheetProvider [
	"Create a new stylesheet provider instance.
	Default implementation returns nil (no stylesheets used)."
	^ nil
]
