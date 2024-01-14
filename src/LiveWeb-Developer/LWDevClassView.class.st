Class {
	#name : #LWDevClassView,
	#superclass : #LWBulmaComponent,
	#instVars : [
		'classDef',
		'methods',
		'cls',
		'export'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassView >> cls: aClass [
 cls := aClass.
 classDef changed.
 methods child: self createMethodListing.
]

{ #category : #compiling }
LWDevClassView >> compile: side source: source [
	| target |
	target := side = 'instance'
		          ifTrue: [ cls ]
		          ifFalse: [ cls class ].
	target compile: source.
	"FIXME: should listen to method announcement? should only change/add method that was compiled"
	methods child: self createMethodListing .
	
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

{ #category : #rendering }
LWDevClassView >> renderClassDefOn: h [
  h div: { #class -> 'section' } with: [  
  cls ifNil: [ h div: 'No class selected'. ^ nil ].
  h div: [ 
		h strong: 'Name: '; span: cls name
		"FIXME: show slots, superclass and so on"
  ] 
]
	
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
