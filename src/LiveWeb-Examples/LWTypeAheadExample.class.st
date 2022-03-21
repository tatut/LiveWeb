Class {
	#name : #LWTypeAheadExample,
	#superclass : #LWComponent,
	#instVars : [
		'typeahead'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWTypeAheadExample >> children [ 
	^ ReadStream on: { typeahead }

]

{ #category : #'component lifecycle' }
LWTypeAheadExample >> initialize [
	super initialize.	
	typeahead := LWTypeAhead new 
		renderValueString: #name;
		resolveCandidateId: [ :candidateId | candidateId asClass  ];
		renderCandidate: [ :h | h
			 div: { h templateAttr: 'data-typeahead-id' with: #name } with: [ h
           b: [ h templateSlot: #name ];
           span: [ h templateSlot: [ :c | c subclasses size asString ] ]]];
     fetchCandidates: [ :v | 
			Smalltalk globals allClasses select: [ :c | (v,'*') match: c name ]];
		accessor: #first;
		form: (LWEditForm new entity: OrderedCollection new) .

]

{ #category : #rendering }
LWTypeAheadExample >> renderOn: h [
	h div: [ 
		h h3: 'Type ahead from Smalltalk image classes:'.
		typeahead render: h ]

]
