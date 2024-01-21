Class {
	#name : #LWDevClassView,
	#superclass : #LWComponent,
	#instVars : [
		'cls',
		'slot',
		'examples'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassView >> children [ 
 ^ ReadStream on: { examples  }

]

{ #category : #accessing }
LWDevClassView >> cls: aClass [
 cls := aClass.
 self changed.

]

{ #category : #initialization }
LWDevClassView >> initialize [ 
 super initialize.
 examples := LWDevClassExamplesView new.

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
LWDevClassView >> renderOn: h [
 h div: {#slot->slot. #style-> 'display: inline-flex; flex-direction: column; overflow-y: scroll'}
   with: [  
	  self renderClassDefOn: h.
	  examples render: h.
	]
]

{ #category : #accessing }
LWDevClassView >> slot: slotName [ 
 slot := slotName
]
