Class {
	#name : #LWDevSpotter,
	#superclass : #LWComponent,
	#instVars : [
		'dialog',
		'menu'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevSpotter >> children [ 
 ^ReadStream on: { dialog }

]

{ #category : #'typing/selecting keys' }
LWDevSpotter >> find: aString [ 
 | find classes classMenu |
 classMenu := SlMenu new.
 find := aString trim.
 find isEmpty
  ifTrue: [ classMenu add: (SlMenuItem new disabled: true; add: 'Type part of class name to search'; yourself) ]
  ifFalse: [  
	classMenu on: SlSelectEvent do: [ :e | e inspect ]. "selected something!"
   find := '*{1}*' format: { aString }.
   classes := (Smalltalk globals allClasses select: [ :c | find match: c name ]) takeFirst: 20.
   classes 
		collect: [ :c | SlMenuItem new value: c name; add: c name; yourself ]
		into: classMenu.
 ].
 menu child: classMenu.
]

{ #category : #initialization }
LWDevSpotter >> initialize [
 super initialize.
 menu := LWSingleContainer new. 
 self find: ''. "init menu with empty selection"
 dialog := SlDialog new 
		className: 'spotter';
		label: 'Jump to class';
		add: (SlInput new placeholder: 'class...'; autofocus: true;
			on: SlInputEvent do: (Js debounced: [ :e | self find: e value ] wait: (Duration milliSeconds: 250)));
		add: menu;
		yourself. 
 
]

{ #category : #rendering }
LWDevSpotter >> renderOn: h [
 dialog render: h
]
