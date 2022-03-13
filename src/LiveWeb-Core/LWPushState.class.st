"
I am a component that renders scripts needed to support push state in the browser.
"
Class {
	#name : #LWPushState,
	#superclass : #LWComponent,
	#instVars : [
		'page'
	],
	#classInstVars : [
		'page'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'instance creation' }
LWPushState class >> on: page [
	^ self new page: page; yourself
]

{ #category : #accessing }
LWPushState >> page: aPage [
  page := aPage 
]

{ #category : #rendering }
LWPushState >> renderOn: h [
	| cb initial |
	cb := ctx registerCallback: [ :state | page pushStateChanged: state ] for: self.
	initial := STONJSON toString: page initialPushState asPushStateJSON.  
	h script: [ 
		h raw: ('window.onload=function(){_lw.enablePushState(<1s>, <2s>)}' expandMacrosWith: initial with: cb asString)
   ]
]
