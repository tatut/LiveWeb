"
I render the styles provided by LWStylesheetProvider and track changes.
Any new styles added will be immediately sent to connected clients.
"
Class {
	#name : #LWStylesheetComponent,
	#superclass : #LWComponent,
	#instVars : [
		'stylesheetProvider'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #'instance creation' }
LWStylesheetComponent class >> on: stylesheetProvider [
	^ self new stylesheetProvider: stylesheetProvider; yourself
]

{ #category : #'component lifecycle' }
LWStylesheetComponent >> mount [
	stylesheetProvider addStyleAddedListener: self
]

{ #category : #'as yet unclassified' }
LWStylesheetComponent >> onStyleAdded: css [ 
	Transcript show: 'lisättiinpä css: ', css;cr.
]

{ #category : #rendering }
LWStylesheetComponent >> renderOn: h [
	h style: [ h write: stylesheetProvider ]
]

{ #category : #accessing }
LWStylesheetComponent >> stylesheetProvider: anObject [

	stylesheetProvider := anObject
]

{ #category : #'component lifecycle' }
LWStylesheetComponent >> unmount [
	stylesheetProvider removeStyleAddedListener: self
]
