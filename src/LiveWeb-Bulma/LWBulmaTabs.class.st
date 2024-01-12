Class {
	#name : #LWBulmaTabs,
	#superclass : #LWComponent,
	#instVars : [
		'tabs',
		'styles',
		'active',
		'onchange'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #convenience }
LWBulmaTabs >> activate: tab [ 
  active := tab value.
  onchange value: tab value.
  self changed.
]

{ #category : #accessing }
LWBulmaTabs >> active: activeTabValue [
 active := activeTabValue
]

{ #category : #'as yet unclassified' }
LWBulmaTabs >> beCentered [
 styles add: 'is-centered'
]

{ #category : #styling }
LWBulmaTabs >> beLarge [
 styles add: 'is-large'
]

{ #category : #styling }
LWBulmaTabs >> beMedium [
 styles add: 'is-medium'
]

{ #category : #'as yet unclassified' }
LWBulmaTabs >> beRight [
 styles add: 'is-right'
]

{ #category : #styling }
LWBulmaTabs >> beSmall [
 styles add: 'is-small'
]

{ #category : #initialization }
LWBulmaTabs >> initialize [ 
  super initialize.
  styles := #('tabs') asOrderedCollection.
  tabs := OrderedCollection new.
]

{ #category : #accessing }
LWBulmaTabs >> onchange: aBlock [
	"Set the block to call with the selected tab component."
	onchange := aBlock
]

{ #category : #rendering }
LWBulmaTabs >> renderActiveTab: h [
  | tab | 
  tab := tabs detect: [ :t | t key = active ].
  tab render: h
]

{ #category : #rendering }
LWBulmaTabs >> renderOn: h [
	h div: [ 
		"Render tab bar" 
		self renderTabbar: h.
		     "renderActiveTab: h"
	]
]

{ #category : #rendering }
LWBulmaTabs >> renderTabbar: h [
	^ h div: { (#class -> (' ' join: styles)) } with: [
		  h ul: [
			  tabs do: [ :tab |
				  h
					  li: { (#class -> (tab value = active
							    ifTrue: [ 'is-active' ]
							    ifFalse: [ '' ])).
							  #onclick -> [ self activate: tab ] }
					  with: [ h a: tab key ] ] ] ]
]

{ #category : #accessing }
LWBulmaTabs >> tab: nameToValueAssociation [
 tabs add: nameToValueAssociation.
 active ifNil: [ active := nameToValueAssociation key ].
 self changed 
]
