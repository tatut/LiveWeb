"
I am a component that installs a global listener to the JS window object.
The listener is automatically removed when this component is removed from the DOM.
"
Class {
	#name : #LWWindowListener,
	#superclass : #LWComponent,
	#instVars : [
		'event',
		'callback',
		'listenerId'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWWindowListener class >> on: event call: callback [
	"create new listener for the given event type and callback.
	Callback can be a block or an instance of LWScriptCallback."
	^ self new event: event; callback: callback.
]

{ #category : #accessing }
LWWindowListener >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
LWWindowListener >> event: anObject [
	event := anObject
]

{ #category : #rendering }
LWWindowListener >> renderOn: h [
	| callbackId |
	callbackId := (ctx registerCallback: callback for: self).
	listenerId := '_lwlisten',id asString.
	h script: [ 
		h streamContents: [ :out |
			"Output script that adds the listener when window is ready.
			The listener is removed on unmount."
			out
			  << listenerId; << ' = {id: '; << callbackId asString; << ', cb: ';
			  << '(event) => '; << (callback asLWScriptCallback asJS: listenerId,'.id'); <<' };';
			  << 'window.addEventListener("load", () => window.addEventListener("'; 
			  << event; << '", '; << listenerId; << '.cb));'.
		]]
]

{ #category : #'component lifecycle' }
LWWindowListener >> unmount [ 
	self send: 'E' with: 
		(String streamContents: [:out | out 
			<< 'window.removeEventListener("';
			<< event; << '", ' ;
			<< listenerId; << '.cb); ';
			<< 'delete '; << listenerId; << ';' ])
]
