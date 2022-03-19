"
I provide selecting a single entity by a type ahead find.
User can type text which will trigger a server side search.
"
Class {
	#name : #LWTypeAhead,
	#superclass : #LWBaseEditor,
	#instVars : [
		'template',
		'renderCandidate',
		'fetchCandidates',
		'renderValueString',
		'candidateId'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWTypeAhead >> candidateId: aBlockOrSymbol [
  "Set accessor to get id for candidate. Needed to resolve selected 
  value back into an entity."
	candidateId := aBlockOrSymbol
]

{ #category : #accessing }
LWTypeAhead >> children [ 
	| s |
	s := super children.
	^ Generator on: [ :yield |
		[ s atEnd ] whileFalse: [ yield value: s next ].
		template ifNotNil: [ yield value: template ]
	]
]

{ #category : #'actions api' }
LWTypeAhead >> fetch: aString [
	| candidates |
	candidates := fetchCandidates value: aString.
	template renderItems: candidates to: (accessor,'-candidates').
	
	"FIXME: should structure more elegantly, so this could be done with add/remove class patches"
	self send: 'E' with: 'this.querySelector(".formCandidates").style.display="block"'
]

{ #category : #accessing }
LWTypeAhead >> fetchCandidates: aBlock [
	"Set block to fetch candidates. Receives the input text as parameter."
	fetchCandidates := aBlock
]

{ #category : #'as yet unclassified' }
LWTypeAhead >> inputAndErrorClass [ 
  ^ self style formTypeAhead 
]

{ #category : #'component lifecycle' }
LWTypeAhead >> mount [ 	
	template := LWTemplate new template: renderCandidate.
	super mount

]

{ #category : #rendering }
LWTypeAhead >> renderAfterInput: h [
	template render: h.
	h script: [ h streamContents: [ :out | self renderJsOn: out ]];
	  div: { #class->#typeAheadCandidates } with: [
		h div: { #class -> 'formCandidates'. #id -> (accessor,'-candidates') } ]
	
]

{ #category : #accessing }
LWTypeAhead >> renderCandidate: aBlock [
	"Set block to render a candidate template. Used in an LWTemplate and 
	can include #templateSlot: calls that receive the fetched data."
	renderCandidate := aBlock
]

{ #category : #rendering }
LWTypeAhead >> renderInput: h hasError: error [
	h input: { 
		#name -> accessor. 
		#id -> accessor.
		#onkeyup -> 
			((Js call: [:v | self fetch: v] with: (Js inputValue: accessor)) 
				debounceMs: 300;
				condition: '_lw_typeAhead',accessor,'(event)')
	 }
]

{ #category : #rendering }
LWTypeAhead >> renderJsOn: out [
	"Render JS code needed in the client side."
	out << 'function _lw_typeAhead'; << accessor; << '(event) {
	
		return true;
	}'
]

{ #category : #accessing }
LWTypeAhead >> renderValueString: aBlock [ 
	renderValueString := aBlock

]
