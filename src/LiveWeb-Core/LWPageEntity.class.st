Class {
	#name : #LWPageEntity,
	#superclass : #ZnEntity,
	#instVars : [
		'head',
		'body'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #testing }
LWPageEntity class >> designatedMimeType [
	""
	^ 'application/liveweb-html' asZnMimeType 
]

{ #category : #accessing }
LWPageEntity >> body: anObject [

	body := anObject
]

{ #category : #testing }
LWPageEntity >> designatedMimeType [ 
	^ 'text/html'

]

{ #category : #accessing }
LWPageEntity >> head: anObject [

	head := anObject
]

{ #category : #testing }
LWPageEntity >> isEmpty [
	^ false
]

{ #category : #writing }
LWPageEntity >> writeOn: stream [
	| h |
	stream nextPutAll: '<!doctype html>'; nextPut: Character lf.
	h := HTMLRenderer on: stream.
	h html: 
	[ h head: [ 
		"output JS to connect websocket"
		head ifNotNil: [ head render: h ].
	   ].
     h body: [ 
		body render: h
	 ]
   ].
	stream close.

]
