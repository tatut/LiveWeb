"
I am a Bulma button component. 

I have content and an onclick action. 
My look can be tweaked with the styling methods like #bePrimary and #beOutlined.

"
Class {
	#name : #LWBulmaButton,
	#superclass : #LWContainer,
	#instVars : [
		'styles',
		'onclick'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #styling }
LWBulmaButton >> beBlack [
 self style: 'is-black'
]

{ #category : #styling }
LWBulmaButton >> beDanger [
 self style: 'is-danger'
]

{ #category : #styling }
LWBulmaButton >> beDark [
 self style: 'is-dark'
]

{ #category : #styling }
LWBulmaButton >> beFullWidth [ 
 self style: 'is-fullwidth'
]

{ #category : #styling }
LWBulmaButton >> beGhost [
 self style: 'is-ghost'
]

{ #category : #styling }
LWBulmaButton >> beInfo [
 self style: 'is-info'
]

{ #category : #styling }
LWBulmaButton >> beInverted [ 
 self style: 'is-inverted'
]

{ #category : #styling }
LWBulmaButton >> beLarge [
 self style: 'is-large'.
]

{ #category : #styling }
LWBulmaButton >> beLight [
 self style: 'is-light'
]

{ #category : #styling }
LWBulmaButton >> beLink [
 self style: 'is-link'
]

{ #category : #styling }
LWBulmaButton >> beLoading [
	self style: 'is-loading'
]

{ #category : #styling }
LWBulmaButton >> beMedium [
 self style: 'is-medium'.
]

{ #category : #styling }
LWBulmaButton >> beNormal [
 self style: 'is-normal'.
]

{ #category : #styling }
LWBulmaButton >> beOutlined [ 
 self style: 'is-outlined'
]

{ #category : #styling }
LWBulmaButton >> bePrimary [
 self style: 'is-primary'
]

{ #category : #styling }
LWBulmaButton >> beRounded [ 
 self style: 'is-rounded'
]

{ #category : #styling }
LWBulmaButton >> beSmall [ 
 self style: 'is-small'.
]

{ #category : #styling }
LWBulmaButton >> beStatic [ 
 self style: 'is-static'
]

{ #category : #styling }
LWBulmaButton >> beSuccess [
 self style: 'is-success'
]

{ #category : #styling }
LWBulmaButton >> beText [
 self style: 'is-text'
]

{ #category : #styling }
LWBulmaButton >> beWarning [
 self style: 'is-warning'
]

{ #category : #styling }
LWBulmaButton >> beWhite [ 
 self style: 'is-white'
]

{ #category : #initialization }
LWBulmaButton >> initialize [ 
  super initialize.
  styles := #('button') asOrderedCollection
]

{ #category : #accessing }
LWBulmaButton >> onclick: aBlock [
 onclick := aBlock.
]

{ #category : #rendering }
LWBulmaButton >> renderOn: h [
 h button: { #onclick -> onclick. 
             #class -> (' ' join: styles) } 
   with: [ self renderChildren: h ]
 
]

{ #category : #accessing }
LWBulmaButton >> style: styleToAdd [
 styles add: styleToAdd
]

{ #category : #styling }
LWBulmaButton >> toggleLoading [
	(styles includes: 'is-loading')
	  ifTrue: [ styles remove: 'is-loading' ]
	  ifFalse: [ styles add: 'is-loading' ]
]
