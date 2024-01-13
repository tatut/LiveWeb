Class {
	#name : #LWExportJS,
	#superclass : #LWComponent,
	#instVars : [
		'export'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWExportJS >> export: nameToCallbackAssociation [
 export add: nameToCallbackAssociation.
]

{ #category : #initialization }
LWExportJS >> initialize [ 
 super initialize.
 export := OrderedCollection new.
]

{ #category : #rendering }
LWExportJS >> renderOn: h [
	h script: [ 
		export do: [ :e |
			| name cb cbId argNames |
			name := e key.
			cb := e value.
			argNames := ',' join: ((1 to: cb numArgs) collect: [ :i | 'a{1}' format: { i } ]).
			cbId := ctx registerCallback: cb for: self.
			h raw: 'function '; raw: name asString; raw: '('; raw: argNames;
			  raw: '){_lws('; raw: cbId asString; raw: ',['; raw: argNames; raw: '])} '.
		]
   ]
]
