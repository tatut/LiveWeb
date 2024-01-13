Class {
	#name : #LWDevListing,
	#superclass : #LWComponent,
	#instVars : [
		'filter',
		'export',
		'listing'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevListing >> children [ 
 ^ ReadStream on: { export. listing }

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

{ #category : #'as yet unclassified' }
LWDevListing >> filterJSName [ 
 ^ 'filter{1}' format: { ('' join: self class name splitCamelCase allButFirst) }
]

{ #category : #initialization }
LWDevListing >> initialize [ 
 super initialize.
 filter := ''.
 export := LWExportJS new 
	export: self selectJSName -> [ :sel | self select: sel ].
 listing := LWBlockContainer new block: [ :h | self renderListingOn: h ]
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
	h tbody: [
	  self items do: [ :p |
		  h tr: [
			  h
				  td: { (#onclick -> ('{1}(''{2}'')' format: {
							    self selectJSName.
							    (self itemName: p) })) }
				  with: p name ] ] ]
]

{ #category : #rendering }
LWDevListing >> renderOn: h [

	h div: { #style -> 'height: 95vh;' } with: [
		export render: h.
		h input: {
				(#placeholder -> 'filter...').
				(#value -> filter).
				(#id -> self filterJSName).
				(#oninput -> ((Js
					   call: [ :f | self filter: f ]
					   with: (Js inputValue: self filterJSName)) debounceMs: 300)) }.
		h div: { #style->'height:90vh;overflow-y:scroll;' } with: [ 
		h table: { #class -> 'table is-striped' } with: [
			h thead: [ h tr: [ h td: self label ] ].
			listing render: h] ]
	]
]

{ #category : #enumerating }
LWDevListing >> select: value [ 
 self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
LWDevListing >> selectJSName [ 
 ^ 'select{1}' format: { ('' join: self class name splitCamelCase allButFirst) }
]
