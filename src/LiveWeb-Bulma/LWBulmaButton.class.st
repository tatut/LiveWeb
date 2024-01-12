Class {
	#name : #LWBulmaButton,
	#superclass : #LWContainer,
	#instVars : [
		'styles',
		'onclick'
	],
	#category : #'LiveWeb-Bulma'
}

{ #category : #'as yet unclassified' }
LWBulmaButton >> beBlack [
 style := 'is-black'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beDanger [
 style := 'is-danger'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beDark [
 style := 'is-dark'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beFullWidth [ 
 self style: 'is-fullwidth'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beGhost [
 style := 'is-ghost'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beInfo [
 style := 'is-info'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beInverted [ 
 self style: 'is-inverted'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beLarge [
 self style: 'is-large'.
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beLight [
 self style: 'is-light'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beLink [
 self style: 'is-link'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beMedium [
 self style: 'is-medium'.
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beNormal [
 self style: 'is-normal'.
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beOutlined [ 
 self style: 'is-outlined'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> bePrimary [
 self style: 'is-primary'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beRounded [ 
 self style: 'is-rounded'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beSmall [ 
 self style: 'is-small'.
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beSuccess [
 self style: 'is-success'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beText [
 self style: 'is-text'
]

{ #category : #'as yet unclassified' }
LWBulmaButton >> beWarning [
 self style: 'is-warning'
]

{ #category : #'as yet unclassified' }
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
