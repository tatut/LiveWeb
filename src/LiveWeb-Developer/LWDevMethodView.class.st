Class {
	#name : #LWDevMethodView,
	#superclass : #LWComponent,
	#instVars : [
		'method',
		'cls',
		'instance'
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
 ^ ReadStream on: { }

]

{ #category : #accessing }
LWDevMethodView >> cls: aClass [
 cls := aClass
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> codeFormat [ 
 ^ self isHTML 
	ifTrue:  ['html']
	ifFalse: ['st']
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> codeSource [ 
 ^ self isHTML 
   ifTrue: [ self htmlSource ]
   ifFalse: [ method sourceCode ]
]

{ #category : #'as yet unclassified' }
LWDevMethodView >> htmlSource [ 
 ^ (method pragmaAt: #lwHTML:) argumentAt: 1
]

{ #category : #testing }
LWDevMethodView >> isHTML [ 
 ^ (method pragmaAt: #lwHTML:) isNotNil 
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
		         'data-class' -> cls name.
		          #onclick -> ('initEditor(''{1}'')' format: {self codeFormat}).
				    #class -> 'codeEditor'. #style -> 'max-height: 40vh; overflow-y: scroll;' } 
		  with: [  h renderContent: self codeSource ].
 	]
]
