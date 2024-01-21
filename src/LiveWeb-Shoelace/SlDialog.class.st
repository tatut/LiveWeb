Class {
	#name : #SlDialog,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlDialog class >> elementAttributes [ 
 ^#( 
 (open boolean)
)
]

{ #category : #'as yet unclassified' }
SlDialog class >> elementSlots [ 
 ^#( label 'header-actions' 'footer' )
]

{ #category : #'as yet unclassified' }
SlDialog class >> simpleDialogExample [ 
 <lwExample: 'Simple dialog with footer button'>
 | d |
 ^ LWContainer with: {
   d := SlDialog new 
		add: 'this is a dialog.. neat.';
		footer: (SlButton new 
			attrAt: #onclick update: [[ d open: false ]];
			add: 'close'; yourself).
	(SlButton new 
		attrAt: #onclick update: [[ d open: true ]];
		add: 'open dialog'; yourself) }
]

{ #category : #'as yet unclassified' }
SlDialog >> footer [
		^ self slotAt: 'footer'.
]

{ #category : #'as yet unclassified' }
SlDialog >> footer: aComponentOrString [
		self slotAt: 'footer' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlDialog >> headerActions [
		^ self slotAt: 'header-actions'.
]

{ #category : #'as yet unclassified' }
SlDialog >> headerActions: aComponentOrString [
		self slotAt: 'header-actions' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlDialog >> label [
		^ self slotAt: 'label'.
]

{ #category : #'as yet unclassified' }
SlDialog >> label: aComponentOrString [
		self slotAt: 'label' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlDialog >> open [
		^ self attrAt: 'open'
]

{ #category : #'as yet unclassified' }
SlDialog >> open: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'open' update: [ newValue ]
]
