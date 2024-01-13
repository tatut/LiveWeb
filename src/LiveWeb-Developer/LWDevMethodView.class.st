Class {
	#name : #LWDevMethodView,
	#superclass : #LWComponent,
	#instVars : [
		'method',
		'example'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevMethodView >> children [ 
 ^ ReadStream on: { example }

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
		h div: [ h strong: method selector asString ]; 
		  textarea: { #rows -> '7'. #cols -> '80' } with: method sourceCode
 	]
]
