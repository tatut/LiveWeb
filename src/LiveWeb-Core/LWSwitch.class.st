"
I am a simple switch component with one child.
When the switch is ON, the child is rendered. 
When the switch is OFF, an invisible script placeholder is rendered. 
"
Class {
	#name : #LWSwitch,
	#superclass : #LWComponent,
	#instVars : [
		'child',
		'on'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWSwitch >> child [

	^ child
]

{ #category : #accessing }
LWSwitch >> child: anObject [

	child := anObject
]

{ #category : #accessing }
LWSwitch >> children [ 
	^ ReadStream on: { child }
]

{ #category : #testing }
LWSwitch >> isOn [ 
	"is the switch on?"
	^ on
	
]

{ #category : #accessing }
LWSwitch >> off [
	"set the switch to off (hiding the component)"
	on := false.
	child isMounted ifTrue: [ ctx cleanup: child unmount: true ].
	self changed.
]

{ #category : #accessing }
LWSwitch >> on [
	"set the switch to on (showing the component)"
	on := true.
	self changed.
]

{ #category : #rendering }
LWSwitch >> renderOn: h [
	on ifTrue: [ h span: [ child render: h ] ]
		ifFalse: [ h script: { #type -> 'liveweb/placeholder' } with: '' ]
]

{ #category : #operations }
LWSwitch >> toggle [
	"If switch is OFF, turn it ON... and vice versa."
	on ifTrue: [ self off ] ifFalse: [ self on ]

]
