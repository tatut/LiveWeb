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
		'children',
		'id',
		'mounted',
		'ctx'
	],
	#classVars : [
		'js'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #initialization }
LWComponent class >> initialize [
	js := LWScriptHelper 
]

{ #category : #adding }
LWComponent >> add: aChildComponent [
	"add child component to this component"
	children ifNil: [ children := OrderedCollection new ].
	aChildComponent inContext: ctx.
	children add: aChildComponent.
	mounted ifTrue: [ ctx component: self childAdded: aChildComponent at: children size ]
]

{ #category : #updating }
LWComponent >> changed [ 
	"Signal that this component state has changed and should be rerendered.
	Do not call this when adding or removing children, as they are handled
	separately. Calling changed will cause the whole component to be rerendered
	and sent to the client page."
	ctx ifNotNil: [ ctx componentChanged: self ].
]

{ #category : #accessing }
LWComponent >> childCount [
	^ children ifNil: 0 ifNotNil: [ children size ]
]

{ #category : #enumerating }
LWComponent >> childrenDo: aBlock [
	"run block with each child"			
	children ifNotNil: [ 
		children do: [ :child | aBlock value: child ]].
	
]

{ #category : #accessing }
LWComponent >> id [

	^ id
]

{ #category : #'instance creation' }
LWComponent >> inContext: aContext [
	ctx := aContext.
	id := ctx registerComponent: self.
	self childrenDo: [ :c | c inContext: ctx ].
	
]

{ #category : #initialization }
LWComponent >> initialize [
	mounted := false.
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
	Mounts the component before first render.
	Sets the component id to renderer before calling renderOn:. 
	Subclasses should not override this, but instead override renderOn: to produce HTML."
	| oldId oldComp |
	mounted ifFalse: [ 
		self mount.
		mounted := true. 
	].

	"keep old id and component safe in stack, 
	restore them if parent renders something after rendering children"
	oldId := aHtmlRenderer id.
	oldComp := aHtmlRenderer component.
	aHtmlRenderer id: id; component: self.
	self renderOn: aHtmlRenderer.
	aHtmlRenderer id: oldId; component: oldComp.
]

{ #category : #rendering }
LWComponent >> renderOn: aHtmlRenderer [
	"Subclasses should override this to produce HTML"
	SubclassResponsibility new signal: 'LWComponent subclasses must implement renderOn: '
]
