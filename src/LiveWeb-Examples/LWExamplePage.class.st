Class {
	#name : #LWExamplePage,
	#superclass : #LWStyledPage,
	#category : #'LiveWeb-Examples'
}

{ #category : #'instance creation' }
LWExamplePage class >> of: componentClass [
	^ self new componentClass: componentClass.
]

{ #category : #accessing }
LWExamplePage class >> value: req [
	"create new instance of example page for request"
	^ self new value: req.
]

{ #category : #accessing }
LWExamplePage >> body: _args [
	^ LWExampleMain new state: self initialPushState
]

{ #category : #accessing }
LWExamplePage >> componentClass: cls [
	| page |
	page := args uri path.
	"this is only for the demo, don't use reflection in real use"
	componentClass := self class environment at: 'LW' , page capitalized
]

{ #category : #'push state handling' }
LWExamplePage >> initialPushState [ 
	| example |
	example := args uri segments last.
	Transcript show: 'we got the args: ', example asString; cr.
	
	^ { #example -> example } asDictionary 
]

{ #category : #'push state handling' }
LWExamplePage >> pushStateChanged: newState [
	Transcript show: 'tulipa uusi tila: ', newState asString;cr.
	body state: newState.
]

{ #category : #'as yet unclassified' }
LWExamplePage >> stylesheetProvider [ 
	^ LWStylesheetProvider provider: LWExampleStyles 

]

{ #category : #'push state handling' }
LWExamplePage >> usePushState [ 
	^ true

]
