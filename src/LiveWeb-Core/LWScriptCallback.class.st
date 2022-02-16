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
		'debounceMs',
		'preventDefault'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #converting }
LWScriptCallback >> asJS: cb [
	^ String streamContents: [ :js |
		preventDefault ifTrue: [ js nextPutAll: 
			'window.event.preventDefault();' ].
		condition ifNotNil: [ js nextPutAll: 'if('; nextPutAll: condition; nextPutAll: ') '  ].
		js nextPutAll: '_lws('; 
			nextPutAll: cb asString; 
			nextPutAll:',['.
		jsParams 	doWithIndex: [ :p :i | 
			i > 1 ifTrue: [ js nextPut: $, ].
			js nextPutAll: p.		
		].
		js nextPutAll: ']'.
		debounceMs ifNotNil: [ js nextPut: $‚; nextPutAll: debounceMs asString ].
		js nextPut: $) ]
]

{ #category : #converting }
LWScriptCallback >> asLWScriptCallback [ 
  ^ self
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

{ #category : #initialization }
LWScriptCallback >> initialize [ 
	preventDefault := false.
	jsParams := #().
]

{ #category : #accessing }
LWScriptCallback >> jsParams [

	^ jsParams
]

{ #category : #accessing }
LWScriptCallback >> jsParams: anObject [

	jsParams := anObject
]

{ #category : #accessing }
LWScriptCallback >> preventDefault: prevent [
	preventDefault := prevent
]

{ #category : #evaluating }
LWScriptCallback >> valueWithArguments: args [
  ^ callback valueWithArguments: args
]
