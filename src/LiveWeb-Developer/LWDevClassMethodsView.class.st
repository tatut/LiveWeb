Class {
	#name : #LWDevClassMethodsView,
	#superclass : #LWSingleContainer,
	#instVars : [
		'cls',
		'slot'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassMethodsView >> cls: aClass [ 
 cls := aClass.
 self createMethodListing.
]

{ #category : #'as yet unclassified' }
LWDevClassMethodsView >> createMethodListing [ 
  | methodList |
  methodList :=  LWContainer new.
  (cls class methods sorted: [:a :b | a name < b name]) do: [ :m |
	  methodList add: (LWDevMethodView new beClass cls: cls; method: m)
  ].
  (cls methods sorted: [ :a :b | a name < b name ]) do: [ :m |
	 methodList add: (LWDevMethodView new beInstance cls: cls; method: m)
	].
  self child: methodList


 

]

{ #category : #rendering }
LWDevClassMethodsView >> renderOn: h [
 h div: { #slot -> slot. #style -> 'overflow-y: scroll;' }
   with: [ 
	  super renderOn: h	
 ]
]

{ #category : #accessing }
LWDevClassMethodsView >> slot: slotName [ 
 slot := slotName
]

{ #category : #'as yet unclassified' }
LWDevClassMethodsView >> update: isInstance method: named [
 | in mv |
 in := self child children.
 [ mv := in next ] whileNotNil: [ 
	(mv method selector = named) & (isInstance = mv isInstance) ifTrue: [ 
		mv refresh.
		^ nil
	]
 ]
 "No method was found? This must be a new method, add it."
]
