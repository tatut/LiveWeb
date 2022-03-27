"
I am a version of LWStyle that builds up a dictionary of the properties
instead of directly writing the declarations to a stream.

I can be used to extend styles as it is possible to add the same property multiple times.
The last property of the same name wins.

"
Class {
	#name : #LWStyleBuilder,
	#superclass : #LWStyle,
	#instVars : [
		'props',
		'childStyles'
	],
	#category : #'LiveWeb-Styling'
}

{ #category : #'as yet unclassified' }
LWStyleBuilder >> child: cssSelector with: aStyleBlock [
	childStyles 
		at: cssSelector 
		put: aStyleBlock
	
]

{ #category : #accessing }
LWStyleBuilder >> childStyles [
	^ childStyles
]

{ #category : #initialization }
LWStyleBuilder >> initialize [
	props := Dictionary new.
	childStyles := Dictionary new.
]

{ #category : #rendering }
LWStyleBuilder >> render: cssPropertyName value: value [
	props at: cssPropertyName put: value
]

{ #category : #writing }
LWStyleBuilder >> writeOn: stream [
	"write the built style to given stream"
	props keysAndValuesDo: [ :prop :val |
		stream
		 nextPutAll: prop; 
		 nextPutAll: ': ';
		 nextPutAll: val asCSSPropertyValue;
		 nextPutAll: '; ' ]
]
