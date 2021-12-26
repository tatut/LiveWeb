Class {
	#name : #LWMultiCounter,
	#superclass : #LWComponent,
	#category : #'LiveWeb-Examples'
}

{ #category : #'component lifecycle' }
LWMultiCounter >> mount [
	"create some counters"
	1 to: 5 do: [ :i |
		self add: (LWCounter new counter: (2 raisedTo: i)) ]
]

{ #category : #rendering }
LWMultiCounter >> renderOn: h [
	h div: { #class -> 'multicounter' }
	  with: [ 
		self childrenDo: [ :c |
			c render: h .
			h hr.
		].
		h div: { #style -> 'display: flex; flex: row;' }
			with: [ 
				h input: { #id -> #initialCount }.
				h button: { #onclick -> (js call: [ :c | self add: (LWCounter new counter: c asNumber) ] with: (js inputValue: 'initialCount')) }
				  with: 'Add new counter'		
				 ]
		
	]
]
