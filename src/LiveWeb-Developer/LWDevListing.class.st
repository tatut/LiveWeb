Class {
	#name : #LWDevListing,
	#superclass : #LWComponent,
	#instVars : [
		'filter',
		'filterInput',
		'export',
		'listing',
		'slot'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevListing >> children [ 
 ^ ReadStream on: { filterInput. listing }

]

{ #category : #accessing }
LWDevListing >> filter [

	^ filter
]

{ #category : #accessing }
LWDevListing >> filter: anObject [
	filter := anObject trim.
	listing changed 
]

{ #category : #accessing }
LWDevListing >> filteredItems [ 
  | items f |
  items := self items.
  filter isEmpty ifTrue: [ ^ items ].
  f := '*{1}*' format: { filter }.
  ^ items select: [ :p | f match: (self itemName: p) ]
]

{ #category : #initialization }
LWDevListing >> initialize [ 
 super initialize.
 filter := ''.
 filterInput := SlInput new on: SlInputEvent do: (Js debounced: [ :e | self filter: e value ] wait: (Duration milliSeconds: 200));
	size: 'small';
	placeholder: ('{1}...' format: {self label}).
 listing := SlMenu new dynamicItems: [ :h | self renderListingOn: h];
	on: SlSelectEvent do: [ :e | 
		self select: e selectedItemValue ] .

]

{ #category : #scripting }
LWDevListing >> itemName: item [ 
 ^ item name
]

{ #category : #accessing }
LWDevListing >> items [ 
 self subclassResponsibility 
]

{ #category : #accessing }
LWDevListing >> label [ 
 self subclassResponsibility 

]

{ #category : #rendering }
LWDevListing >> renderListingOn: h [
	self filteredItems do: [ :item |
		| n |
		n := self itemName: item.
		h render: 'sl-menu-item'
		  attrs: { #value -> n. #class -> 'listing-menu-item' }
		  with: n 
	].
]

{ #category : #rendering }
LWDevListing >> renderOn: h [
	h div: { #slot-> slot } with: [
		filterInput render: h.
		h div: { #style -> 'display: inline-block; width: 100%; height: 90vh; overflow-y: scroll; overflow-x: hidden;' } 
		  with: [ 
			listing render: h.
		]
	]
]

{ #category : #enumerating }
LWDevListing >> select: value [ 
 self subclassResponsibility 
]

{ #category : #accessing }
LWDevListing >> slot: slotName [ 
 slot := slotName
]
