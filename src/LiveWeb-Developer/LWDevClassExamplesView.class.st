Class {
	#name : #LWDevClassExamplesView,
	#superclass : #LWComponent,
	#instVars : [
		'select',
		'example',
		'selectedExampleName',
		'cls'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevClassExamplesView >> children [ 
 ^ReadStream on: { select }

]

{ #category : #initialization }
LWDevClassExamplesView >> initialize [ 
 super initialize.
 select := LWSingleContainer new. "SlSelect"

]

{ #category : #rendering }
LWDevClassExamplesView >> renderOn: h [
 h div: [  	select render: h.  ]
]
