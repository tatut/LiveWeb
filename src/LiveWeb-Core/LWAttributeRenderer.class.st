Class {
	#name : #LWAttributeRenderer,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWAttributeRenderer >> parent: anObject [

	parent := anObject
]

{ #category : #rendering }
LWAttributeRenderer >> render: attributeEntry [
	"Render an attribute value to string, may do some special handling.
	Returns a new association with value processed.
	Default implementation just returns attribute mapping as is."
	^ attributeEntry 
]
