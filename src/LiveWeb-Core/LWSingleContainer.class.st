"
I am a container that contains a single child. This is useful to hold one 
selected component to show (for example a selected tab content).

When a child is set, the current child (if any) is unmounted and cleaned up.
"
Class {
	#name : #LWSingleContainer,
	#superclass : #LWComponent,
	#instVars : [
		'child',
		'containerElement',
		'containerAttributes'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWSingleContainer >> child: aChildComponent [
	"Set the new child component"
	child ifNotNil: [ ctx cleanup: child unmount: true ].
	child := aChildComponent.
	ctx ifNotNil: [ child inContext: ctx ].
	self changed.

]

{ #category : #accessing }
LWSingleContainer >> children [
	^ Generator on: [ :yield | 
			child ifNotNil: [ yield value: child ]
			]
]

{ #category : #accessing }
LWSingleContainer >> containerAttributes: anObject [

	containerAttributes := anObject
]

{ #category : #accessing }
LWSingleContainer >> containerElement: anObject [

	containerElement := anObject
]

{ #category : #initialization }
LWSingleContainer >> initialize [ 
   super initialize.
	containerElement := #span.
	containerAttributes := Array empty.
]

{ #category : #rendering }
LWSingleContainer >> renderOn: h [
	child
	 ifNil: [ h script: { #type -> 'liveweb/placeholder' } with: '' ]
	 ifNotNil: [ 
		h render: containerElement attrs: containerAttributes with: [ child render: h ] 
	 ]
]
