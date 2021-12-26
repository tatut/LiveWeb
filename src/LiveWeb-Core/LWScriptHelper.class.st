"
I contain helpers to add JS functionality to callbacks.
"
Class {
	#name : #LWScriptHelper,
	#superclass : #Object,
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWScriptHelper class >> eventChangeValue [ 
	^ 'window.event.target.value'
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> eventEnterPressed [ 
	^ self eventKeyCodeIs: 13
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> eventEscPressed [ 
	^ self eventKeyCodeIs: 27
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> eventKeyCodeIs: keycode [ 
	^ 'window.event.keyCode == ', keycode asString.
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> formValues: selector [
 ^ '(()=>{
     let d = {};
     for(const e of new FormData(document.querySelector(''<1s>'')).entries())
        d[e[0]]=e[1];
     return d;})()' expandMacrosWith: selector
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> inputValue: id [ 
	^ 'document.getElementById(''<1s>'').value' expandMacrosWith: id
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> preventDefault [
 ^ 'window.event.preventDefault'
	
]
