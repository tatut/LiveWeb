Class {
	#name : #LWDevClassView,
	#superclass : #LWComponent,
	#instVars : [
		'classDef',
		'methods',
		'cls',
		'export',
		'slot'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassView >> children [ 
 ^ ReadStream on: { export. classDef. methods  }

]

{ #category : #accessing }
LWDevClassView >> cls: aClass [
 cls := aClass.
 classDef changed.
 methods child: self createMethodListing.
]

{ #category : #compiling }
LWDevClassView >> compile: side source: source [
	| target methodName |
	target := side = 'instance'
		          ifTrue: [ cls ]
		          ifFalse: [ cls class ].
	methodName := target compile: source.
	"FIXME: should listen to method announcement? should only change/add method that was compiled"
	"methods child: self createMethodListing ."
	self update: side = 'instance' method: methodName.
	
]

{ #category : #'as yet unclassified' }
LWDevClassView >> createMethodListing [ 
  | methodList |
  methodList :=  LWContainer new 
	containerElement: #div; 
	containerAttributes: { #class -> 'is-flex is-flex-direction-column' }.
  (cls class methods sorted: [:a :b | a name < b name]) do: [ :m |
	  methodList add: (LWDevMethodView new beClass cls: cls; method: m)
  ].
  (cls methods sorted: [ :a :b | a name < b name ]) do: [ :m |
	 methodList add: (LWDevMethodView new beInstance cls: cls; method: m)
	].
  ^ methodList


 

]

{ #category : #initialization }
LWDevClassView >> initialize [ 
 super initialize.
 export := LWExportJS new export: #lwCompileMethod -> [ :side :source | self compile: side source: source ].
 classDef := LWBlockContainer new block: [ :h | self renderClassDefOn: h ].
 methods := LWSingleContainer new.
]

{ #category : #accessing }
LWDevClassView >> render: h [
 h div: {#slot->slot. #style-> 'display: inline-flex; flex-direction: column; height: 95vh; overflow-y: scroll'}
   with: [  
	  export render: h.
	  classDef render: h.
	  methods render: h
	]
]

{ #category : #rendering }
LWDevClassView >> renderClassDefOn: h [
  h div: { #class -> 'section' } with: [  
  cls 
	ifNil: [ h div: 'No class selected'. ]
   ifNotNil: [
	  h div: [ 
		 h strong: 'Name: '; span: cls name
		 "FIXME: show slots, superclass and so on"
    ] 
  ]
 ]
	
]

{ #category : #accessing }
LWDevClassView >> slot: slotName [ 
 slot := slotName
]

{ #category : #'as yet unclassified' }
LWDevClassView >> update: isInstance method: named [
 | in mv |
 in := methods child children.
 [ mv := in next ] whileNotNil: [ 
	(mv method selector = named) & (isInstance = mv isInstance) ifTrue: [ 
		mv refresh.
		^ nil
	]
 ]
 "No method was found? This must be a new method, add it."
]

{ #category : #accessing }
LWDevClassView >> view: view [
 ^view flexCol 
	attr: #style -> 'height: 95vh; overflow-y: scroll';
	add: export;
	add: (view box add: classDef; yourself);
	add: (view box add: methods; yourself);
	yourself
]
