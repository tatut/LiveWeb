"
I am an component that manages an ordered collection of child components.
"
Class {
	#name : #LWContainer,
	#superclass : #LWComponent,
	#instVars : [
		'children',
		'containerElement',
		'containerAttributes'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWContainer class >> flex: direction [
	"Convenience to create a div with flex direction."
	^ self new 
		containerElement: #div;
		containerAttributes: { #style -> ('display: flex; flex-direction: ', direction asString) }
		
]

{ #category : #adding }
LWContainer >> add: aChildComponent [
	^ self add: aChildComponent beforeIndex: children size + 1
]

{ #category : #adding }
LWContainer >> add: aChildComponent beforeIndex: idx [
	"add child component to this component"
	children ifNil: [ children := OrderedCollection new ].
	aChildComponent inContext: ctx.
	children add: aChildComponent beforeIndex: idx.
	mounted ifTrue: [ ctx component: self childAdded: aChildComponent at: idx ].
	^ aChildComponent 
]

{ #category : #accessing }
LWContainer >> childCount [
	^ children ifNil: 0 ifNotNil: [ children size ]
]

{ #category : #enumerating }
LWContainer >> childrenDo: aBlock [
	"run block with each child"			
	children ifNotNil: [ 
		children do: [ :child | aBlock value: child ]].
	
]

{ #category : #accessing }
LWContainer >> containerAttributes: anObject [

	containerAttributes := anObject
]

{ #category : #accessing }
LWContainer >> containerElement: anObject [

	containerElement := anObject
]

{ #category : #initialization }
LWContainer >> initialize [ 
	super initialize.
	children := OrderedCollection new.
	containerElement := #span.
	containerAttributes := #().
	
]

{ #category : #rendering }
LWContainer >> renderOn: h [ 
	h render: containerElement 
	  attrs: containerAttributes 
	  with: [ self children do: [:c | c render: h ] ].
]
