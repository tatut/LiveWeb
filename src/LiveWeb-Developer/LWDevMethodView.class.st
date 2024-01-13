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

{ #category : #accessing }
LWDevMethodView >> method: aMethod [
 method := aMethod
]

{ #category : #rendering }
LWDevMethodView >> renderOn: h [
	h div: { #class -> 'is-box' } with: [ 
		h div: [ h strong: method selector asString;
			        span: { #class -> 'tag is-light' } with: (instance ifTrue: [ 'instance' ] ifFalse: ['class'])
			 ]; 
		  textarea: { #rows -> '7'. #cols -> '80' } with: method sourceCode.
 		(method pragmaAt: #lwExample:) ifNotNil: [ :exp |
			| desc |
			desc := exp argumentAt: 1.
			h div: [ 
			 h input: { #name -> method name. #type -> 'checkbox'. #onchange -> [ self toggleExample ] };
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
 	  ifTrue: [ example child: (cls perform: method selector)  ] 
	  ifFalse: 	[ example child: nil ]
		
]
