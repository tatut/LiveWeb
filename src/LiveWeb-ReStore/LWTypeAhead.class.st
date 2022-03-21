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
		'resolveCandidateId'
	],
	#category : #'LiveWeb-ReStore'
}

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
	
	"Initialize the UI stuff and show the results"
	self send: 'E' with: '_lw_typeAhead',accessor,'Results(this)'
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

{ #category : #parsing }
LWTypeAhead >> parseValue: aFormValue [
	^ resolveCandidateId value: aFormValue
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
	can include #templateSlot: calls that receive the fetched data.
	
	The template MUST have the template attribute 'date-typeahead-id' that
	will be used to select the actual item. The value is passed to the block passed 
	to #resolveCandidateId: as a string."
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
	| selectCallback |
	selectCallback := (ctx registerCallback: self setter for: self) asString.
	"PENDING: we need a sort 'include once' functionality that takes adds 
	a specfic script to the page if it isn't already present (like the styling with classes)"
	out << '
	_lw_typeAhead'; << accessor; << 'Idx=null; 
	function _lw_typeAhead'; << accessor; << '(event) {
		console.log(event.keyCode);
		let e = _lw.get('; << id asString; << ');
		let idx = _lw_typeAhead'; << accessor; <<'Idx;
		let cs = e.querySelectorAll("[data-typeahead-id]");
		switch(event.keyCode) { 
		case 38: /*up*/
		  if(idx!==null) cs[idx].classList.remove("highlight"); 
		  idx = (idx==0||idx==null?cs.length:idx)-1;
		  _lw_typeAhead'; << accessor; <<'Idx=idx;
		  cs[idx].classList.add("highlight");
		  event.preventDefault(); return false;		
		case 40: /*dn*/
		  if(idx!==null) cs[idx].classList.remove("highlight");
		  idx = (idx==cs.length-1||idx==null?0:idx+1);
		  _lw_typeAhead'; << accessor; <<'Idx=idx;
		  cs[idx].classList.add("highlight");
		  event.preventDefault(); return false;
		case 13: /*sel*/
		  if(idx!==null) _lws(';<<selectCallback; <<',[cs[idx].getAttribute("data-typeahead-id")]);
        event.preventDefault(); return false;		
		}
		return true;
	}
	function _lw_typeAhead'; << accessor; << 'Results(elt) {
	  elt.querySelector(".formCandidates").style.display="block";
	  elt.querySelectorAll("[data-typeahead-id]").forEach(e=>e.onclick=_=>_lws('; << selectCallback; << ',[e.getAttribute("data-typeahead-id")]));
	}'
]

{ #category : #accessing }
LWTypeAhead >> renderValueString: aBlock [ 
	renderValueString := aBlock

]

{ #category : #accessing }
LWTypeAhead >> resolveCandidateId: anObject [

	resolveCandidateId := anObject
]
