Class {
	#name : #LWExamplePage,
	#superclass : #LWPage,
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
