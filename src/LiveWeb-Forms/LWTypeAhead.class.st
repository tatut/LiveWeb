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
	#category : #'LiveWeb-Forms'
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
	self send: 'E' with: 'this.candidatesRendered()'
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
		"#onkeydown -> 'if(event.keyCode==40||event.keyCode==38)event.preventDefault()'.
		#onkeyup -> 
			((Js call: [:v | self fetch: v] with: (Js inputValue: accessor)) 
				debounceMs: 300;
				condition: '_lw_typeAhead',accessor,'(event)')"
	 }
]

{ #category : #rendering }
LWTypeAhead >> renderJsOn: out [
	"Render JS code needed in the client side."
	| init |
	(ctx at: #TypeAheadScript) ifNil: [   
		ctx at: #TypeAheadScript put: true.	
		out << '_lwTypeAhead = function(id, fetchCallbackId, selectCallbackId) { 
			let e = _lw.get(id);
			let s = { idx: null, val: "" };			 
			let input = e.querySelector("input");
			input.onkeydown = event => { 
			  if(event.keyCode==40||event.keyCode==38)
			    event.preventDefault(); 
			};
			input.onkeyup = event => { 
			   let cs = e.querySelectorAll("[data-typeahead-id]");
				switch(event.keyCode) { 
				case 38: /*up*/
		  			if(s.idx!==null) cs[s.idx].classList.remove("highlight"); 
		  			s.idx = (s.idx==0||s.idx==null?cs.length:s.idx)-1;
		 			cs[s.idx].classList.add("highlight");
					break;
				case 40: /*dn*/
		  			if(s.idx!==null) cs[s.idx].classList.remove("highlight");
		  			s.idx = (s.idx==cs.length-1||s.idx==null?0:s.idx+1);
				   cs[s.idx].classList.add("highlight");
				   break;
				case 13: /*sel*/
		  			if(s.idx!==null) _lws(selectCallbackId,[cs[s.idx].getAttribute("data-typeahead-id")]);
        			event.preventDefault();
			      break;
			   default:  
					if(input.value!==s.value)	{ 
				     s.value = input.value;
					  let c = e.querySelector(".typeAheadCandidates");
					  c.classList.add("loading");
					  c.classList.remove("noResults");
					  e.querySelector(".formCandidates").style.display="none";
				     _lws(fetchCallbackId, [ s.value ], 300);
				   }
				}
			};
			e.candidatesRendered = () => {
				e.querySelector(".typeAheadCandidates").classList.remove("loading");
				if(e.querySelectorAll("[data-typeahead-id]").length == 0) { 
					e.querySelector(".typeAheadCandidates").classList.add("noResults");
				} else {  
  		   			e.querySelector(".formCandidates").style.display="block";
					e.querySelectorAll("[data-typeahead-id]").forEach(e=>e.onclick=_=>_lws(selectCallbackId,[e.getAttribute("data-typeahead-id")]));
				}	
			};
	};' ].
	"Output code to initialize this instance"
	"PENDING: LiveWeb could directly support this type of behaviour to initialize JS components that have been
	 defined in data attributes like <div data-lw-class=TypeAhead data-lw-fetch=.../>.
	LiveWeb could automatically initialize instances on load and when replacing/adding elements."
	init := '_lwTypeAhead(',id asString,', ',(ctx registerCallback: [ :v | self fetch: v ] for: self) asString,',',(ctx registerCallback: self setter for: self) asString,');'.
	out 
		<< 'if(typeof(_lw)==="undefined") { window.addEventListener("load", _ => { '; << init; 
		<< '}); } else { '; << init; << ' }'.
	
]

{ #category : #accessing }
LWTypeAhead >> renderValueString: aBlock [ 
	renderValueString := aBlock

]

{ #category : #accessing }
LWTypeAhead >> resolveCandidateId: anObject [

	resolveCandidateId := anObject
]
