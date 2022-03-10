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
	entity refresh. "make sure it is refreshed from db"
	form := LWEditForm forEntityClass: entity class.
	form	configure: [ :f | 
		entity class = Customer ifTrue: [ 
			f allFieldsConfigure: #hideLabel;
 			  renderBlock: [ :h :renderChild | 
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
					
					] 
			]
		]
	] .
	form exclude: #name;
		   entity: entity.
	 
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
LWCrudExample >> renderOn: h [
	h div: [ 
		form render: h.
		h br; button: { #onclick -> [ form submit ] } with: 'Save' 
   ]
]
