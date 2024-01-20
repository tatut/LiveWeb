Class {
	#name : #SlAlert,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlAlert class >> elementAttributes [ 
 ^ #( 
 (open boolean)
 (closable boolean)
 (variant (primary success neutral warning danger))
 (duration number)
), super elementAttributes 

]

{ #category : #'as yet unclassified' }
SlAlert class >> elementSlots [  
 ^ #(icon)
]

{ #category : #'as yet unclassified' }
SlAlert class >> simpleAlertWithTextExample [
 <lwExample: 'Simple alert with text'>
 ^ self new add: 'I''m an alert and I''m okay!'; open: true
]

{ #category : #'as yet unclassified' }
SlAlert class >> toastExample [ 
 <lwExample: 'Example of moving alert to toast'>
 ^ LWContainer new
    add: (self new variant: 'success'; className: 'example-toast'; 
				icon: (SlIcon new name: 'lungs');
				duration: 3000;
				add: 'to your continued health!'; yourself);
    add: (SlButton new 
  				on: SlClickEvent do: 'document.querySelector(".example-toast").toast()';
				add: 'toast it'; yourself);
	 yourself
]

{ #category : #'as yet unclassified' }
SlAlert class >> warningAlertWithIconExample [ 
 <lwExample: 'Warning and icon'>
 ^ self new 
	 	add: 'Something alarming just happened!';
		variant: 'warning';
		icon: (SlIcon new name: 'exclamation-triangle');
		open: true.
]

{ #category : #'as yet unclassified' }
SlAlert >> closable [
		^ self attrAt: 'closable'
]

{ #category : #'as yet unclassified' }
SlAlert >> closable: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'closable' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> duration [
		^ self attrAt: 'duration'
]

{ #category : #'as yet unclassified' }
SlAlert >> duration: newValue [
		self assert: newValue isNumber.
		self attrAt: 'duration' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> icon [
		^ self slotAt: 'icon'.
]

{ #category : #'as yet unclassified' }
SlAlert >> icon: aComponentOrString [
		self slotAt: 'icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlAlert >> open [
		^ self attrAt: 'open'
]

{ #category : #'as yet unclassified' }
SlAlert >> open: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'open' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> slot [
		^ self attrAt: 'slot'
]

{ #category : #'as yet unclassified' }
SlAlert >> slot: newValue [
		self assert: newValue isString.
		self attrAt: 'slot' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlAlert >> variant [
		^ self attrAt: 'variant'
]

{ #category : #'as yet unclassified' }
SlAlert >> variant: newValue [
		self assert: ( #( 'primary' 'success' 'neutral' 'warning' 'danger' ) includes: newValue).
		self attrAt: 'variant' update: [ newValue ]
]
