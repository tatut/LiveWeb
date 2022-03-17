Class {
	#name : #LWClassAttribute,
	#superclass : #Object,
	#instVars : [
		'cls'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #accessing }
LWClassAttribute >> , aClassAttribute [ 

^ self class new cls: (cls,' ',aClassAttribute value); yourself
]

{ #category : #accessing }
LWClassAttribute >> cls: aClassName [
	cls := aClassName
]

{ #category : #accessing }
LWClassAttribute >> key [ 
	^ #class
]

{ #category : #accessing }
LWClassAttribute >> value [ 
  ^ cls

]
