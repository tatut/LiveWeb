Class {
	#name : #LWDevClassView,
	#superclass : #LWComponent,
	#instVars : [
		'cls',
		'slot',
		'examples',
		'classInfo'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassView >> children [ 
 ^ ReadStream on: { classInfo. examples  }

]

{ #category : #accessing }
LWDevClassView >> cls: aClass [
 cls := aClass.
 examples cls: aClass.
 classInfo changed. 

]

{ #category : #initialization }
LWDevClassView >> initialize [ 
 super initialize.
 classInfo := LWBlockContainer new block: [ :h | self renderClassDefOn: h ].
 examples := LWDevClassExamplesView new.

]

{ #category : #updating }
LWDevClassView >> methodChanged: methodSelector [ 
 examples updateExample
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
	  classInfo render: h.
	  h render: 'sl-divider' with: ''.
	  examples render: h.
	]
]

{ #category : #accessing }
LWDevClassView >> slot: slotName [ 
 slot := slotName
]
