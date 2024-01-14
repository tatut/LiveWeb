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
	ctx ifNotNil: [ aChildComponent inContext: ctx ].
	children add: aChildComponent beforeIndex: idx.
	mounted ifTrue: [ ctx component: self childAdded: aChildComponent at: idx ].
	^ aChildComponent 
]

{ #category : #'as yet unclassified' }
LWContainer >> attr: nameValueAssociation [ 
	"Set the container attribute. Overwriting it if it exists."
	self attr: nameValueAssociation key update: [ nameValueAssociation value ]
]

{ #category : #'as yet unclassified' }
LWContainer >> attr: name update: block [ 
	"Update attribute container attribute. Creating it if it does not exist.
	 If the attribute doesn't exist, the update block is called with an empty string.
	 If the component is mounted, the new attribute will be patched in."
	| attrs newVal |
	attrs := containerAttributes asOrderedCollection.
	attrs detect: [ :a | a name = name ] 
	 ifFound: [ :assoc | newVal := (block cull: assoc value). assoc value: newVal ]
	 ifNone: [ newVal := (block cull: ''). attrs add: name -> newVal ].
	containerAttributes := attrs.
	self send: '@' with: { name -> newVal } asDictionary.

]

{ #category : #accessing }
LWContainer >> childCount [
	^ children ifNil: 0 ifNotNil: [ children size ]
]

{ #category : #accessing }
LWContainer >> children [
	^ ReadStream on: children
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
LWContainer >> renderChildren: h [
	self children do: [ :c | c render: h ]
]

{ #category : #rendering }
LWContainer >> renderOn: h [
	h render: containerElement
	  attrs: containerAttributes
	  with: [ self renderChildren: h ]
]
