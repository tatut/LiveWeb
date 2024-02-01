Class {
	#name : #LWTodoItem,
	#superclass : #Object,
	#instVars : [
		'label',
		'complete'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #API }
LWTodoItem >> beComplete [ 
 self complete: true
]

{ #category : #accessing }
LWTodoItem >> complete [

	^ complete
]

{ #category : #accessing }
LWTodoItem >> complete: anObject [

	complete := anObject
]

{ #category : #initialization }
LWTodoItem >> initialize [ 
 super initialize.
 complete := false.

]

{ #category : #accessing }
LWTodoItem >> label [

	^ label
]

{ #category : #accessing }
LWTodoItem >> label: anObject [

	label := anObject
]
