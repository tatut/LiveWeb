"
I am a component that renders an HTML custom element (like WebComponent).

I can optionally add JavaScript code to add event listeners for custom events (see LWCustomEvent).
"
Class {
	#name : #LWCustomElement,
	#superclass : #LWComponent,
	#instVars : [
		'eventListeners',
		'slots',
		'attrs'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWCustomElement >> attrAt: name [
	^ attrs at: name
]

{ #category : #'as yet unclassified' }
LWCustomElement >> attrAt: attrName update: aBlock [
   | oldVal newVal |
	attrs ifNil: [
		attrs := SmallDictionary new.
	].
	oldVal := attrs at: attrName ifAbsent: [ nil ].
	newVal := aBlock cull: nil.
	attrs at: attrName put: newVal.
	^ newVal
	
]

{ #category : #accessing }
LWCustomElement >> children [ 
	^ Generator on: [ :g |
		slots associationsDo: [ :slot |
 			g yield: slot value 
		]
	 ]
]

{ #category : #initialization }
LWCustomElement >> initialize [ 
  super initialize. 

]

{ #category : #convenience }
LWCustomElement >> on: aLWCustomEventType do: aBlock [
 eventListeners ifNil: [ eventListeners := OrderedCollection new. ].
 eventListeners add: aLWCustomEventType -> aBlock
]

{ #category : #rendering }
LWCustomElement >> renderCustomEvents: h [
 | c |
 eventListeners isEmpty ifTrue: [ ^ nil ].
 "Output a script that finds the rendered element and adds listeners to it"
 c := '_c{1}' format: { id }.
 h script: [ 
	h raw: 'window.addEventListener("load",function(){ const '; raw: c; raw: ' = _lw.get('; raw: id asString; raw: ');'.
	eventListeners do: [ :e |
		| cb event callback |
		event := e key.
		callback := e value.
		cb := ctx registerCallback: [ :d | |evt|
			evt := event fromDictionary: d.
			callback value: evt ] for: self. 
      h raw: c; raw: '.addEventListener("'; raw: event type; raw: '",e=>_lws(';
        raw: cb asString; raw: ', ['; raw: event eventJS; raw: ']));'
    ].
  h raw: '})'
]
]

{ #category : #rendering }
LWCustomElement >> renderOn: h [
	h render: self tag 
	  attrs: (attrs ifNotNil: [ attrs ] ifNil: [ #() ])
	  with: (slots ifNotNil: [ [ self renderSlots: h ] ] ifNil: ['']).
	self renderCustomEvents: h.
]

{ #category : #rendering }
LWCustomElement >> renderSlots: h [
	slots valuesDo: [ :c | c render: h ]
]

{ #category : #accessing }
LWCustomElement >> slotAt: slotName [ 
	^ self slots at: slotName.
]

{ #category : #accessing }
LWCustomElement >> slotAt: slotName put: aComponent [
   ctx ifNotNil: [ aComponent inContext: ctx ].
	self slots at: slotName 
		update: [ :oldComponent |
			self ifMounted: [ ctx removeComponent: oldComponent ].
			aComponent ]
		initial: aComponent.
	self ifMounted: [ ctx component: self appendChild: aComponent ]
]

{ #category : #accessing }
LWCustomElement >> slots [ 
	slots ifNil: [ slots := SmallDictionary new ].
	^ slots
]

{ #category : #accessing }
LWCustomElement >> tag [ 
 self subclassResponsibility 
]
