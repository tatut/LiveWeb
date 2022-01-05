Class {
	#name : #LWStyledPage,
	#superclass : #LWPage,
	#category : #'LiveWeb-Styling'
}

{ #category : #rendering }
LWStyledPage >> htmlRenderer: stream [
	| r |
	r := super htmlRenderer: stream.
	r withAttributeRenderer: LWStyleAttributeRenderer new.
	^ r

]
