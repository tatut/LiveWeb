Class {
	#name : #LWTreeExample,
	#superclass : #LWComponent,
	#instVars : [
		'root'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWTreeExample >> children [ 
^ ReadStream on: { root }
]

{ #category : #initialization }
LWTreeExample >> initialize [ 
  super initialize.
  root := LWTreeNode new label: 'Smalltalk packages'; beBranch.
  Smalltalk packages sorted do: [ :p|
	| node |
	node := root. 
	(p name splitOn: $-) do: [ :part |
		node := node branch: part.
	].
   p classes do: [ :c |
		node leaf: c name
	 ]
  ]
]

{ #category : #rendering }
LWTreeExample >> renderOn: h [
	root render: h
]
