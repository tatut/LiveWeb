Class {
	#name : #LWStyleAttributeRenderer,
	#superclass : #LWAttributeRenderer,
	#instVars : [
		'styles'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #'as yet unclassified' }
LWStyleAttributeRenderer >> cssDeclarations [
	"render this item as CSS declarations string"
	| decls at first |
	decls := Set new.
	at := self.
	[ at name = 'Object' ] whileFalse: [  
		"FIXME: check only for known CSS properties"
		decls addAll: (at selectors select: [ :sel | (sel asString indexOf: $:) = 0 ]).
		at := at superclass.
	].

	"output all values"
	first := true.
	^ String streamContents: [ :out |
		decls do: [ :sel |
			| prop val |
			first ifTrue: [ out nextPutAll: '; '. first := false ].
			val := self perform: sel.
			prop := sel asCSSPropertyName.
			out nextPutAll: prop; nextPut: $:; nextPutAll: val asCSSPropertyValue.
			  ]	
	] 
	
]

{ #category : #rendering }
LWStyleAttributeRenderer >> render: attributeEntry [  
	| class value |
	"if attribute is not style, delegate to parent"
	attributeEntry key = #style ifFalse: [ ^ parent render: attributeEntry ].
	value := attributeEntry value.
	
	"add value to cached CSS declarations"
	(styles includes: value) ifFalse: [ styles add: value ]. "fixme: hook sending new styles via WS"
	
	^ #class -> value cssClassName
	
]
