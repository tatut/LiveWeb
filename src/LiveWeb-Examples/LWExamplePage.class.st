Class {
	#name : #LWExamplePage,
	#superclass : #LWStyledPage,
	#instVars : [
		'componentClass'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'instance creation' }
LWExamplePage class >> of: componentClass [
	^ self new componentClass: componentClass.
]

{ #category : #accessing }
LWExamplePage >> body: args [
	^ componentClass new
]

{ #category : #accessing }
LWExamplePage >> componentClass: cls [
	componentClass := cls
]

{ #category : #'push state handling' }
LWExamplePage >> initialPushState [ 
	Transcript show: 'we got the args: ', args asString; cr.
	^ { #foo -> 'bar' . #jotain -> 'ihan muuta' } asDictionary 
]

{ #category : #'push state handling' }
LWExamplePage >> pushStateChanged: newState [
	Transcript show: 'tulipa uusi tila: ', newState asString;cr.
]

{ #category : #'as yet unclassified' }
LWExamplePage >> stylesheetProvider [ 
	^ LWStylesheetProvider provider: LWExampleStyles 

]

{ #category : #'push state handling' }
LWExamplePage >> usePushState [ 
	^ true

]
