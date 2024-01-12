"
I am an example of a component that has a container of subcomponents, that can be added.
"
Class {
	#name : #LWMultiCounter,
	#superclass : #LWBulmaComponent,
	#instVars : [
		'counters'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWMultiCounter >> children [ 
	^ ReadStream on: { counters }
	
]

{ #category : #initialization }
LWMultiCounter >> initialize [ 
	super initialize.
	counters := LWContainer flex: #col.
	
]

{ #category : #'component lifecycle' }
LWMultiCounter >> mount [
	"create some counters"
	1 to: 5 do: [ :i |
		counters add: (LWCounter new counter: (2 raisedTo: i)) ]
]

{ #category : #rendering }
LWMultiCounter >> renderOn: h [
	h div: { #class -> 'multicounter' }
	  with: [ 
		h text: 'Here are some counters:'; br.
		counters render: h.
		h br.
		h div: { #style -> 'display: flex; flex: row;' }
		 with: [ 
				h input: { #id -> #initialCount }.
				h button: { #class -> 'button is-outlined'. #onclick -> (Js call: [ :c | counters add: (LWCounter new counter: c asNumber) ] with: (Js inputValue: 'initialCount')) }
				    with: 'Add new counter'		
				 ]]
]
