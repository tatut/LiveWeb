Class {
	#name : #LWTypeAheadExample,
	#superclass : #LWComponent,
	#instVars : [
		'template'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWTypeAheadExample >> children [ 
	^ ReadStream on: { template }

]

{ #category : #'component lifecycle' }
LWTypeAheadExample >> initialize [ 
	super initialize.
	template := LWTemplate new template: [ :h |
		h tr: [ 
			h td: [ h templateSlot: [ :c | c name ] ];
			  td: [ h templateSlot: [ :c | c subclasses size asString ] ]]].

]

{ #category : #rendering }
LWTypeAheadExample >> renderOn: h [
	| resultsId |
	resultsId := id asString,'-matches'.
	h div: [ 
		h h3: 'Type ahead from Smalltalk image classes:';
		  input: { #id -> #classTypeahead. #type -> #text. #onchange -> (Js 
				call: [ :v | 
					| classes |
					classes := Smalltalk globals allClasses select: [ :c | (v,'*') match: c name ].
					template renderItems: classes to: resultsId. ]
				with: (Js inputValue: #classTypeahead)) }.
		template render: h.
		h table: [ 
			h thead: [ 
				h tr: [ h th: 'Name'; th: 'Subclasses' ] ];
			  tbody: { #id -> resultsId } ]
	]
]
