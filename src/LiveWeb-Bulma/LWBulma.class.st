"
I provide a convenient method interface to creating many of the
Bulma LiveWeb components.
"
Class {
	#name : #LWBulma,
	#superclass : #Object,
	#category : #'LiveWeb-Bulma'
}

{ #category : #accessing }
LWBulma >> block [ 
 ^ LWContainer new containerElement: #div; containerAttributes: { #class -> 'block' }
]

{ #category : #accessing }
LWBulma >> box [ 
 ^ LWContainer new containerElement: #div; containerAttributes: { #class -> 'box' }
]

{ #category : #'accessing - structure variables' }
LWBulma >> button [ 
  ^ LWBulmaButton new 
 
]

{ #category : #api }
LWBulma >> columns [ 
	"Create a Bulma columns container"
	 ^ LWBulmaColumns new
]

{ #category : #'as yet unclassified' }
LWBulma >> flexCol [
  ^ LWContainer new containerElement: #div; containerAttributes: { #class -> 'is-flex is-flex-direction-column' }; yourself 

]

{ #category : #'as yet unclassified' }
LWBulma >> flexRow [
  ^ LWContainer new containerElement: #div; containerAttributes: { #class -> 'is-flex is-flex-direction-row' }; yourself 

]

{ #category : #accessing }
LWBulma >> tabs [ 
 ^ LWBulmaTabs new
]

{ #category : #'as yet unclassified' }
LWBulma >> tile [ 
 ^ LWBulmaTile new
]
