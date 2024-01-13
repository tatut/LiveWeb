Class {
	#name : #LWDevClassView,
	#superclass : #LWBulmaComponent,
	#instVars : [
		'classDef',
		'methods',
		'cls'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassView >> cls: aClass [
 cls := aClass.
 classDef changed.
 methods child: self createMethodListing.
]

{ #category : #'as yet unclassified' }
LWDevClassView >> createMethodListing [ 
  | methodList |
  methodList :=  LWContainer new containerElement: #div; containerAttributes: { #class -> 'is-flex is-flex-direction-column' }.
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
 classDef := LWBlockContainer new block: [ :h | self renderClassDefOn: h ].
 methods := LWSingleContainer new.
]

{ #category : #rendering }
LWDevClassView >> renderClassDefOn: h [
  cls ifNil: [ h div: 'No class selected'. ^ nil ].
  h div: [ 
		h strong: 'Name: '; span: cls name
		
  ] 
	
]

{ #category : #accessing }
LWDevClassView >> view: view [
 ^view flexCol 
	add: (view box add: classDef; yourself);
	add: (view box add: methods; yourself);
	yourself
]
