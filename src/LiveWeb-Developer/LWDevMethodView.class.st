Class {
	#name : #LWDevMethodView,
	#superclass : #LWComponent,
	#instVars : [
		'method',
		'cls',
		'instance',
		'example'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #'as yet unclassified' }
LWDevMethodView >> beClass [ 
 instance := false
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> beInstance [
 instance := true
]

{ #category : #accessing }
LWDevMethodView >> children [ 
 ^ ReadStream on: { example }

]

{ #category : #accessing }
LWDevMethodView >> cls: aClass [
 cls := aClass
]

{ #category : #initialization }
LWDevMethodView >> initialize [ 
 super initialize.
 example := LWSingleContainer new.
]

{ #category : #testing }
LWDevMethodView >> isInstance [ 
 ^ instance 
]

{ #category : #accessing }
LWDevMethodView >> method [ 
 ^ method
]

{ #category : #accessing }
LWDevMethodView >> method: aMethod [
 method := aMethod
]

{ #category : #accessing }
LWDevMethodView >> refresh [ 
 | candidates |
 "refetch method from class"
 candidates := instance ifTrue: [ cls methods ] ifFalse: [ cls class methods ].
 method := candidates detect: [ :m | m selector = method selector].
 "Rerender example if one is visible"
 self refreshExample
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> refreshExample [ 
  example hasChild ifTrue: [ 
	example child: (cls perform: method selector) changed. ]
]

{ #category : #rendering }
LWDevMethodView >> renderOn: h [
	h div: { #style -> 'margin: 1em;' } with: [ 
		h render: 'sl-divider' with: ''.
		h div: [ h strong: method selector asString;
			        render: 'sl-divider' with: { #vertical -> true };
			        render: 'sl-tag' attrs: { #variant -> 'neutral'. #size -> 'small' } with: (instance ifTrue: [ 'instance' ] ifFalse: ['class'])
			 ];
		  pre: { 'data-side' -> (instance ifTrue: ['instance'] ifFalse:['class']). 
		          #onclick -> 'initEditor()'.
				    #class -> 'codeEditor bulma-reset-mixin'. #style -> 'max-height: 40vh;' } with: [  h renderContent: method sourceCode ].
 		(method pragmaAt: #lwExample:) ifNotNil: [ :exp |
			| desc |
			desc := exp argumentAt: 1.
			h div: [ 
			 h input: { #id -> method name. #type -> 'checkbox'. #onchange -> [ self toggleExample ] };
			   label: { #for -> method name } with: (' Show example: {1}' format: { desc })
			]
		].
	   example render: h.
	   h div: { #class -> 'block' }
 	]
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> toggleExample [ 
	example hasChild 
 	  ifTrue: [ example child: nil   ] 
	  ifFalse: 	[ example child: (cls perform: method selector) ]
		
]
