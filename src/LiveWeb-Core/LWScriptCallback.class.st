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
		'preventDefault',
		'thenJS'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWScriptCallback >> afterSend: id [
 thenJS ifNil: [ ^ 'null' ].

]

{ #category : #'as yet unclassified' }
LWScriptCallback >> afterSend: js forComponent: id [
 thenJS ifNil: [ ^ nil ].
 js << ',(function(){';
    << thenJS;
    << '}).bind(_lw.get("';
    << id asString;
    << '"))'
 

]

{ #category : #converting }
LWScriptCallback >> asJS: cb forComponent: id [
	^ String streamContents: [ :js |
		preventDefault ifTrue: [ js << 'window.event.preventDefault();' ].
		condition ifNotNil: [ js << 'if(!('; << condition; << ')) return;'  ].
		js << '_lws('; << cb asString; << ',[';
			<< (',' join: jsParams);
			<< '],';
		   << (debounceMs ifNil: [ '0' ] ifNotNil: [ debounceMs asString]).
		self afterSend: js forComponent: id.
		js << ')' ]
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

{ #category : #accessing }
LWScriptCallback >> thenJS: aScript [
	"Set JS code to run immediately after sending the callback.
	JavaScript 'this' is bound to the current component."
 thenJS := aScript
]

{ #category : #evaluating }
LWScriptCallback >> valueWithArguments: args [
  ^ callback valueWithArguments: args
]
