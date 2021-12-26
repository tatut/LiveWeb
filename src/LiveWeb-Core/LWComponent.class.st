"
I am the baseclass for all LiveWeb components. 

Components maintain state of the page. When the page is initially rendered, 
all components are mounted and then rendered to the page.

When a component's state changes, the changed message must be sent to it to 
notify listeners that rerender the component and send it to the connected page.


"
Class {
	#name : #LWComponent,
	#superclass : #Object,
	#instVars : [
		'changeListeners',
		'children',
		'id'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #adding }
LWComponent >> add: aChildComponent [
	"add child component to this component"
	children ifNil: [ children := OrderedCollection new ].
	children add: aChildComponent 
]

{ #category : #updating }
LWComponent >> changed [ 
	"Signal that this component state has changed and should be rerendered.
	Do not call this when adding or removing children, as they are handled
	separately. Calling changed will cause the whole component to be rerendered
	and sent to the client page."
	changeListeners ifNotNil: [ 
		changeListeners do: [ :l | l value: self ] ].
]

{ #category : #enumerating }
LWComponent >> childrenDo: aBlock [
	"run block with each child"			
	children ifNotNil: [ 
		children do: [ :child | aBlock value: child ]].
	
]

{ #category : #initialization }
LWComponent >> initialize [
	changeListeners := OrderedCollection new.
]

{ #category : #initialization }
LWComponent >> listenToChanges: aListenerBlock [
	changeListeners ifNil: [ changeListeners := OrderedCollection  new ].
	changeListeners add: aListenerBlock 
]

{ #category : #'component lifecycle' }
LWComponent >> mount [
	"Do any initialization before rendering. 
	Component must add any initial child components while mounting.
	Any children added will be mounted by the system."
]

{ #category : #rendering }
LWComponent >> render: aHtmlRenderer [
	"Render this component using HTML renderer. 
	Sets the component id to renderer before calling renderOn:. 
	Subclasses should not override this, but instead override renderOn: to produce HTML."
	aHtmlRenderer id: id.
	self renderOn: aHtmlRenderer .
]

{ #category : #rendering }
LWComponent >> renderOn: aHtmlRenderer [
	"Subclasses should override this to produce HTML"
	SubclassResponsibility new signal: 'LWComponent subclasses must implement renderOn: '
]
