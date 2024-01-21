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
 ^ReadStream on: { select. example }

]

{ #category : #accessing }
LWDevClassExamplesView >> cls: aClass [
 cls := aClass.
 selectedExampleName := nil.
 self updateExamples 
]

{ #category : #initialization }
LWDevClassExamplesView >> initialize [ 
 super initialize.
 select := LWSingleContainer new.
 example := LWSingleContainer new.

]

{ #category : #rendering }
LWDevClassExamplesView >> renderOn: h [
 h div: [
	select render: h. 
	h div: { #style -> 'margin-top: 0.5em;' } with: [ example render: h ]
	]
]

{ #category : #'as yet unclassified' }
LWDevClassExamplesView >> selectExample: selectorName [ 
 Transcript show: 'valitaan ', selectorName; cr.
 selectedExampleName := selectorName.
 self updateExample 

]

{ #category : #'as yet unclassified' }
LWDevClassExamplesView >> updateExample [ 
Transcript show: 'updating!'; cr.
  example child: (selectedExampleName 
 	 ifNil: [ nil  ]
	 ifNotNil: [ 
		[ (cls perform: selectedExampleName asSymbol) ]
		on: Exception
		do: [ :e | SlAlert new 
			add: ('ERROR IN EXAMPLE: {1}' format: {e messageText});
			variant: 'warning';
			icon: (SlIcon named: 'exclamation-triangle');
			open: true ]
	]).
]

{ #category : #'as yet unclassified' }
LWDevClassExamplesView >> updateExamples [ 
 | sel |
 sel := SlSelect new
	size: 'small';
	placeholder: 'Show example...';
	on: SlChangeEvent do: [ :e | self selectExample: e value ].
	
 cls class methods 
	select: [ :m | m hasPragmaNamed: #lwExample: ] 
	thenDo: [ :m | sel add: (SlOption 
		option: ((m pragmaAt: #lwExample:) argumentAt: 1)
		value: m selector) ].
	
 select child: sel.
 self updateExample 
]
