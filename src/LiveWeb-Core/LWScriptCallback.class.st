"
I represent a callback from browser to server that has arguments that are evaluated on JS side.
An callback can also have a JS evaluated condition.
Or a debounce millisecond.



"
Class {
	#name : #LWScriptCallback,
	#superclass : #Object,
	#instVars : [
		'callback',
		'condition',
		'jsParams',
		'debounceMs'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #converting }
LWScriptCallback >> asJS: cb [
	String streamContents: [ :js |
		condition ifNotNil: [ js nextPutAll: 'if('; nextPutAll: condition; nextPutAll: ') '  ].
		js nextPutAll: '_lws('; 
			nextPutAll: cb asString; 
			nextPutAll:',['.
		jsParams 	doWithIndex: [ :p :i | 
			i > 0 ifTrue: [ js nextPut: $, ].
			js nextPutAll: p.		
		].
		js nextPutAll: ']'.
		debounceMs ifNotNil: [ js nextPut: $‚; nextPutAll: debounceMs asString ].
		js nextPut: $) ]
]

{ #category : #accessing }
LWScriptCallback >> callback [

	^ callback
]

{ #category : #accessing }
LWScriptCallback >> callback: anObject [

	callback := anObject
]

{ #category : #accessing }
LWScriptCallback >> condition [

	^ condition
]

{ #category : #accessing }
LWScriptCallback >> condition: anObject [

	condition := anObject
]

{ #category : #accessing }
LWScriptCallback >> debounceMs [

	^ debounceMs
]

{ #category : #accessing }
LWScriptCallback >> debounceMs: anObject [

	debounceMs := anObject
]

{ #category : #accessing }
LWScriptCallback >> jsParams [

	^ jsParams
]

{ #category : #accessing }
LWScriptCallback >> jsParams: anObject [

	jsParams := anObject
]
