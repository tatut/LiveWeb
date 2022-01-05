Class {
	#name : #LWStyleAttributeRenderer,
	#superclass : #LWAttributeRenderer,
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
	"if attribute is not style, delegate to parent"
	attributeEntry key = #style ifFalse: [ ^ parent render: attributeEntry ].

	"if attribute is not a block, don't process this"
	attributeEntry value isBlock ifFalse: [ ^ attributeEntry ].
	
	^ #style -> (String streamContents: [:out |
		attributeEntry value value: (LWStyle on: out)])	
	
	
]
