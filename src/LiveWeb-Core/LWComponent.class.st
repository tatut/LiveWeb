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

{ #category : #updating }
LWComponent >> changed [ 
	"Signal that this component state has changed and should be rerendered.
	Do not call this when adding or removing children, as they are handled
	separately. Calling changed will cause the whole component to be rerendered
	and sent to the client page."
	ctx ifNotNil: [ ctx componentChanged: self ].
]

{ #category : #accessing }
LWComponent >> children [ 
	"Answer with a ReadStream of all children of this component.
	This is used if the component is rerendered, to unmount and clean up all
	child components.
	
	If a component has child components, it must override this method to ensure
	correct behaviour."
	^ ReadStream on: #().
]

{ #category : #'as yet unclassified' }
LWComponent >> childrenRecursive [
	"answer with a read stream of all recursive children for this component.
	This includes all descendants.
	
	The children are returned depth first, the child always returned before the parent."
	^ Generator on: [ :g |
		self children do: [ :c |
			c childrenRecursive do: [ :r | g yield: r ].
			g yield: c.
		 ]
	  ]
]

{ #category : #accessing }
LWComponent >> id [

	^ id
]

{ #category : #'instance creation' }
LWComponent >> inContext: aContext [
 	ctx := aContext.
	id := ctx registerComponent: self.
	self children do: [ :c | c inContext: aContext ].
	
	
]

{ #category : #initialization }
LWComponent >> initialize [
	mounted := false.
]

{ #category : #'component lifecycle' }
LWComponent >> mount [
	"Do any initialization before rendering. 
	Component can acquire resources or start init before the first render."
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

{ #category : #'component lifecycle' }
LWComponent >> unmount [
	"Do any cleanup before component is removed from the page.
	If you started something in mount, you better stop it here!"
]
