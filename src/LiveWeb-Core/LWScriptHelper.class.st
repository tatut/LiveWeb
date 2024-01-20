"
I contain helpers to add JS functionality to callbacks.
"
Class {
	#name : #LWScriptHelper,
	#superclass : #Object,
	#category : #'LiveWeb-Core'
}

{ #category : #construction }
LWScriptHelper class >> call: block [
	^ LWScriptCallback new 
		callback: block
		
	
]

{ #category : #construction }
LWScriptHelper class >> call: block with: jsParam1 [ 
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 }
		
	
]

{ #category : #construction }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 [
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 }
		
	
]

{ #category : #construction }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 with: jsParam3 [ 
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 . jsParam3 }
		
	
]

{ #category : #construction }
LWScriptHelper class >> call: block with: jsParam1 with: jsParam2 with: jsParam3 with: jsParam4 [
	^ LWScriptCallback new 
		callback: block;
		jsParams: { jsParam1 . jsParam2 . jsParam3 . jsParam4 }
		
	
]

{ #category : #construction }
LWScriptHelper class >> debounced: aScriptCallback wait: aDuration [ 
	^ (aScriptCallback asLWScriptCallback) debounceMs: aDuration asMilliSeconds 
]

{ #category : #'script helpers' }
LWScriptHelper class >> eventChangeValue [ 
	^ 'window.event.target.value'
	
]

{ #category : #'script helpers' }
LWScriptHelper class >> eventEnterPressed [ 
	^ self eventKeyCodeIs: 13
	
]

{ #category : #'script helpers' }
LWScriptHelper class >> eventEscPressed [ 
	^ self eventKeyCodeIs: 27
	
]

{ #category : #'script helpers' }
LWScriptHelper class >> eventKeyCodeIs: keycode [ 
	^ 'window.event.keyCode == ', keycode asString.
	
]

{ #category : #'script helpers' }
LWScriptHelper class >> formValues: selector [
 ^ '(()=>{
     let d = {};
     for(const e of new FormData(document.querySelector(''<1s>'')).entries())
        d[e[0]]=e[1];
     return d;})()' expandMacrosWith: selector
]

{ #category : #'script helpers' }
LWScriptHelper class >> inputChecked: id [ 
	^ 'document.getElementById(''<1s>'').checked' expandMacrosWith: id
]

{ #category : #'script helpers' }
LWScriptHelper class >> inputValue: id [ 
	^ 'document.getElementById(''<1s>'').value' expandMacrosWith: id
]

{ #category : #'script helpers' }
LWScriptHelper class >> preventDefault [
 ^ 'window.event.preventDefault'
	
]

{ #category : #construction }
LWScriptHelper class >> when: jsCondition call: block [ 
	^ LWScriptCallback new 
		condition: jsCondition;
		callback: block
	
]

{ #category : #construction }
LWScriptHelper class >> when: jsCondition call: block with: jsParam [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam }
		
	
]

{ #category : #construction }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 }
		
	
]

{ #category : #construction }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 with: jsParam3 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 . jsParam3}
		
	
]

{ #category : #construction }
LWScriptHelper class >> when: jsCondition call: block with: jsParam1 with: jsParam2 with: jsParam3 with: jsParam4 [
	^ (self when: jsCondition call: block) 
		jsParams: { jsParam1 . jsParam2 . jsParam3 . jsParam4 }
		
	
]
