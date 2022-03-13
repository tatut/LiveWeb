Class {
	#name : #LWExamplePage,
	#superclass : #LWStyledPage,
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWExamplePage class >> value: req [
	"create new instance of example page for request"
	^ self new value: req.
]

{ #category : #accessing }
LWExamplePage >> body: _args [
	^ LWExampleMain new state: self initialPushState
]

{ #category : #'push state handling' }
LWExamplePage >> initialPushState [ 
	| example |
	example := args uri segments last.
	LWLogEvent debug: 'we got the args: ', example asString.
	^ { #example -> example } asDictionary 
]

{ #category : #'push state handling' }
LWExamplePage >> pushStateChanged: newState [
	LWLogEvent debug: 'new push state: ', newState asString.
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
