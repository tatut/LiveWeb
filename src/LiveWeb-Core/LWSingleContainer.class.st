"
I am a container that contains a single child. This is useful to hold one 
selected component to show (for example a selected tab content).

When a child is set, the current child (if any) is unmounted and cleaned up.
"
Class {
	#name : #LWSingleContainer,
	#superclass : #LWComponent,
	#instVars : [
		'child'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWSingleContainer >> child: aChildComponent [
	"Set the new child component"
	Transcript show: 'child is being changed!';cr.
	child ifNotNil: [ ctx cleanup: child ].
	child := aChildComponent.
	ctx ifNotNil: [ child inContext: ctx ].
	self changed.
	Transcript show: 'child changed!';cr.
]

{ #category : #accessing }
LWSingleContainer >> children [
	^ Generator on: [ :yield | 
			child ifNotNil: [ yield value: child ]
			]
]

{ #category : #rendering }
LWSingleContainer >> renderOn: h [
	Transcript show: 'rendataas single container ', child printString ;cr.
	child
	 ifNil: [ h script: { #type -> 'liveweb/placeholder' } with: '' ]
	 ifNotNil: [ 
		h span: [ child render: h ] ]
]
