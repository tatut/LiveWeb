"
I contain helpers to add JS functionality to callbacks.
"
Class {
	#name : #LWScriptHelper,
	#superclass : #Object,
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWScriptHelper class >> call: block with: jsParam1 [ 
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 [
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 with: jsParam3 [ 
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 . jsParam3 }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 with: jsParam3 with: jsParam4 [
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 . jsParam3 . jsParam4 }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> debounced: aScriptCallback wait: aDuration [ 
	^ aScriptCallback debounceMs: aDuration asMilliSeconds 
]

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

{ #category : #'as yet unclassified' }
LWScriptHelper class >> when: jsCondition call: block [ 
	^ LWScriptCallback new 
		condition: jsCondition;
		callback: block
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> when: jsCondition call: block with: jsParam [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 }
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 with: jsParam3 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 . jsParam3}
		
	
]

{ #category : #'as yet unclassified' }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 with: jsParam3 with: jsParam4 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 . jsParam3 . jsParam4 }
		
	
]
