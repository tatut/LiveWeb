Class {
	#name : #LWCrudExample,
	#superclass : #LWStyledComponent,
	#instVars : [
		'entity',
		'form'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWCrudExample >> children [
	^ ReadStream on: { form }
]

{ #category : #initialization }
LWCrudExample >> entity: anEntity [ 
	entity := anEntity.
	form := LWEditForm forEntityClass: entity class.

	entity class = Customer ifTrue: [ 
		form
		 exclude: #name;
		 configure: [ :f | 
			f field: #orders configure: [ :coll |
				coll createEditorComponent: [ :order | 
					LWBlockContainer new block: [ :h | 
						h div: 'Add some order edit component here? ', (STON toStringPretty: order) ]
					 ] ]. 
	  "entity class = Customer ifTrue: [ 
			f allFieldsConfigure: #hideLabel;
 			  renderBlock: [ :h :renderChild | self renderCustomizedCustomerFormOn: h renderChild: renderChild ]
		]"
	]].

	form entity: entity.
	 
]

{ #category : #initialization }
LWCrudExample >> initialize [ 
	super initialize.
	entity := Customer new.
	form := LWEditForm forEntityClass: entity class.
	form exclude: #name;
		   entity: entity.
	
]

{ #category : #rendering }
LWCrudExample >> renderCustomizedCustomerFormOn: h renderChild: renderChild [ 
	h div: [ 
	 h table: [
		h tr: [
			h td: 'Nimi: ';
			  td: [ 
					renderChild 
						   value: #firstName; 
							value: #surname.
					]];
			  tr: [ 
				 h td: 'Sähköposti: ';
		        td: [ renderChild value: #emailAddress ]];
				tr: [ 
					h td: 'Synttärit: ';
					  td: [ renderChild value: #dateOfBirth ]]	
					].
		renderChild value: #address.
	]
	
]

{ #category : #rendering }
LWCrudExample >> renderOn: h [
	h div: [ 
		form render: h.
		h br; button: { #onclick -> [ self submit ] } with: 'Save' 
   ]
]

{ #category : #submit }
LWCrudExample >> submit [
  | isNew entityId |
  isNew := form ensureEntity isPersistent not.
  form submit.
  isNew ifFalse: [ ^self ].
  entityId := form entity _id.
  
  ctx go: (LWCrudRouter new matchState: (LWCrudEditState new
		id: form entity _id;
		table: (ctx page initialPushState table))).
   
]
