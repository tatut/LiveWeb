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
		'attrs',
		'content'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #adding }
LWCustomElement >> add: aComponent [ 
  content ifNil: [ content := OrderedCollection new ].
  ^ self add: aComponent beforeIndex: content size + 1
]

{ #category : #adding }
LWCustomElement >> add: aComponent beforeIndex: idx [
   | c |
	"add child component to this component"
	c := aComponent asLWComponent.
	content ifNil: [ content := OrderedCollection new ].
	ctx ifNotNil: [ c inContext: ctx ].
	content add: c beforeIndex: idx.
	mounted ifTrue: [ ctx component: self childAdded: c at: idx ].
	^ c 
]

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
	self send: '@' with: {attrName -> newVal} asDictionary. 
	^ newVal
	
]

{ #category : #accessing }
LWCustomElement >> children [ 
	^ Generator on: [ :g |
		slots ifNotNil: [ 
			slots associationsDo: [ :slot |
 				g yield: slot value 
			]
		].
	   content ifNotNil: [ 
			content do: [ :c | g yield: c ]
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
LWCustomElement >> renderAttrs: h [

	attrs ifNotNil: [
		attrs associationsDo: [ :attr |
			| name val |
			name := attr key.
			val := attr value.
			val ~= false ifTrue: [
				val = true
					ifTrue: [ "boolean attribute that is enabled"
						h out
							<< ' ';
							<< name ]
					ifFalse: [ "some other attribute, stringify"
						h out
							<< ' ';
							<< name;
							<< '="';
							<< (h escapeAttributeValue: val asString);
							<< '"' ] ] "skip boolean attributes that are false" ] ]
]

{ #category : #rendering }
LWCustomElement >> renderContent: h [
  content do: [ :c | c render: h ]
]

{ #category : #rendering }
LWCustomElement >> renderCustomEvents: h [
 | c |
 eventListeners ifNil: [ ^ nil ].
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
	| t |
	t := self tag.
	h out
		<< '<';
		<< t.
	h renderComponentId.
	self renderAttrs: h. 
	h out << '>'.
	slots ifNotNil: [ self renderSlots: h ].
	content ifNotNil: [ self renderContent: h ].
	h out << '</'; << t; << '>'.
	self renderCustomEvents: h
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
	"Slot components must respond to slot: that is used to set the slot name attribute."
	aComponent slot: slotName.
	ctx ifNotNil: [ aComponent inContext: ctx ].
	self slots
		at: slotName
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