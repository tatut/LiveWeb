Class {
	#name : #LWTreeNode,
	#superclass : #LWComponent,
	#instVars : [
		'label',
		'children',
		'expanded',
		'leaf'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWTreeNode class >> exampleSimpleTree [
 <lwExample: 'Simple tree few items'>
 ^ self new beBranch 
     label: 'root';
     child: 'My Documents and settings' do: [ :d | d beBranch; child: 'Music'; child: 'Pictures' ];
     child: 'Secret stuff (don''t look)' do: [ :d | d beBranch; child: 'Passwords & codes' do: [ :p | p beBranch; child: 'Nuclear launch codes' ] ];
     yourself
]

{ #category : #'as yet unclassified' }
LWTreeNode >> beBranch [ 
  leaf := false

]

{ #category : #'as yet unclassified' }
LWTreeNode >> beLeaf [ 
 leaf := true
]

{ #category : #accessing }
LWTreeNode >> branch: childLabel [
	^ (self child: childLabel) beBranch
]

{ #category : #accessing }
LWTreeNode >> child: childLabel [
	"Add or return child with the given label."
	^ children detect:  [ :c | c label = childLabel ]
		ifNone: [ 
			| newChild |
			newChild := self class new label: childLabel.
			children add: newChild.
			newChild 
	 ]
]

{ #category : #'as yet unclassified' }
LWTreeNode >> child: aLabel do: block [ 
  block value: (self child: aLabel).
  ^ self
]

{ #category : #accessing }
LWTreeNode >> children [ 
 ^ReadStream on: children

]

{ #category : #initialization }
LWTreeNode >> initialize [
   super initialize.
	children := OrderedCollection new.
	expanded := false.
	leaf := true.
]

{ #category : #accessing }
LWTreeNode >> label [ 
 ^ label 

]

{ #category : #accessing }
LWTreeNode >> label: aLabel [	
 label := aLabel
]

{ #category : #accessing }
LWTreeNode >> leaf: childLabel [
	^ (self child: childLabel) beLeaf
]

{ #category : #rendering }
LWTreeNode >> renderOn: h [
 h div: { #class -> 'treenode'. 'data-treenode-label' -> label } with: [ 
	h div: { #style -> 'display: flex;' } with: [ 
		leaf 
			ifTrue: [ h span: '[Class]' ] 
			ifFalse: [ 
				h button: { #class -> 'expand'. #onclick -> [ self toggleExpanded ] } with: [ 
 	   				expanded ifTrue: [ h renderContent: '-' ] ifFalse: [ h renderContent: '+' ]]
			].
		h renderContent: ' ', label.
 ].
 expanded ifTrue: [ 
	h ul: { #class -> 'pl-5' } with: [ 
	  children do: [ :c | h li: [ c render: h ] ]
	]
 ]
]
	

]

{ #category : #operations }
LWTreeNode >> toggleExpanded [  
  expanded := expanded not.
  self changed.

]
