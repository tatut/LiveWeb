"
I am a component that installs a global listener to the JS window object.
The listener is automatically removed when this component is removed from the DOM.
"
Class {
	#name : #LWWindowListener,
	#superclass : #LWComponent,
	#instVars : [
		'event',
		'callback'
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
	| js ev |
	js := callback asLWScriptCallback asJS: (ctx registerCallback: callback for: self).
	ev := '"',event asString,'"'.
	h script: [ 
		h streamContents: [ :out |
			"output script that adds the listener when window is ready
			and starts a mutation observer that removes it when this component
			is removed from DOM."
			out 
			  nextPutAll: 'window.addEventListener("load", () => {  
 let listener = (event) => { ';
			  nextPutAll: js;
			  nextPutAll: '};  
 window.addEventListener('; nextPutAll: ev; nextPutAll: ', listener); 
 let me = _lw.get("'; nextPutAll: id asString; nextPutAll: '"); 
 (new MutationObserver((ml) => { console.log("mut: ", ml); 
    ml.forEach((m) => { 
      m.removedNodes.forEach((n) => {
        if(n == me) { 
          window.removeEventListener('; nextPutAll: ev; nextPutAll: ', listener); 
        }
      })
    })
  })).observe(me.parentNode, {subtree:false,childList:true});
 });'
		]
	]
]
