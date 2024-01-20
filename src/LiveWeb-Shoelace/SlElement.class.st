"
I am the base class for all Shoelace custom elements.
I provide methods to access the properties.

"
Class {
	#name : #SlElement,
	#superclass : #LWCustomElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #compiling }
SlElement class >> compileAccessors [
   | props jsOnlyProps |
   props := self elementAttributes asSet. 
   jsOnlyProps := self elementProperties asSet.
 
	props do: [ :p |
		| pname aname ptype typeCheck |
		aname := p first. 
		ptype := p second.
		pname := self kebabToCamel: aname.
		typeCheck := ''.
		ptype isArray ifTrue: [ 
			typeCheck := 'self assert: ( #( {1} ) includes: newValue).' format: { 
				' ' join: (ptype collect: #surroundedBySingleQuotes)
			 }
		].
		ptype = #boolean ifTrue: [ 
			typeCheck := 'self assert: (newValue isKindOf: Boolean).'
		].
	   ptype = #number ifTrue: [ 
		  typeCheck := 'self assert: newValue isNumber.'
		].
	   ptype = #string ifTrue: [ 
		  typeCheck := 'self assert: newValue isString.'
		 ].
		self compile: ('{1}
		^ self attrAt: ''{2}''' format: { pname. aname }).
		self compile: ('{1}: newValue
		{2}
		self attrAt: ''{3}'' update: [ newValue ]' format: { pname. typeCheck. aname }).
		
		
   ]
]

{ #category : #compiling }
SlElement class >> compileAll [ 
	self compileAccessors.
	self compileSlots.
	self subclassesDo: #compileAll.
]

{ #category : #compiling }
SlElement class >> compileSlots [ 
	self elementSlots do: [ :s |
		| sel |
		sel := self kebabToCamel: s.
		self compile: ('{1}
		^ self slotAt: ''{2}''.' format: {sel. s}).
		self compile: ('{1}: aComponentOrString
		self slotAt: ''{2}'' put: (self asSlotComponent: aComponentOrString).' format: {sel. s})
	].
]

{ #category : #'as yet unclassified' }
SlElement class >> elementAttributes [ 
	"Return array of (name type) definitions of all attributes that can be set on the element.
	Type can be a name of a type (like string, boolean or number) or an enum
	of string values."
	^ #( (slot string) )
]

{ #category : #'as yet unclassified' }
SlElement class >> elementProperties [ 
	"Return names of all properties that can be set on the element instance, not including the attributes.
	This includes only those properties that must be set in JavaScript and can't be 
	set as attributes on the element."
	^#()
]

{ #category : #'as yet unclassified' }
SlElement class >> elementSlots [ 
	"Return names of slots. The slots can hold content.
	If not specified by class, no slots will be generated."
	^#()
]

{ #category : #'as yet unclassified' }
SlElement class >> kebabToCamel: kebab [
 | parts |
 parts := kebab splitOn: $-.
 ^String streamContents: [ :out | 
	out << parts first.
	parts allButFirst do: [ :p | out << p capitalized ]
 ]
]

{ #category : #converting }
SlElement >> asSlotComponent: aComponent [ 
 ^ (aComponent respondsTo: #slot:) 
  ifTrue: [ aComponent ]
  ifFalse: [ LWCustomElementSlot new child: (aComponent asLWComponent) ].

]

{ #category : #'as yet unclassified' }
SlElement >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlElement >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]

{ #category : #accessing }
SlElement >> tag [ 
 ^ '-' join: (self class name splitCamelCase collect: #asLowercase)
]
