"
I am a 2 column list of items. 
Each row contains a left and a right component, each with their respective style.

I am usually used for displaying label+value pairs.

for example:

Name:  [text input]
Email: [text input] 


"
Class {
	#name : #LWTwoColumnListing,
	#superclass : #LWContainer,
	#instVars : [
		'style'
	],
	#category : #'LiveWeb-Presenter'
}

{ #category : #'instance creation' }
LWTwoColumnListing >> left: leftComponent right: rightComponent [
	"Add a row to this listing"
	| c | 
	c := LWContainer new.
	c containerElement: #div; 
	  containerAttributes: { style twoColumnListingRow  }.
	c add: (LWSingleContainer new 
		child: leftComponent; 
		containerElement: #div; 
		containerAttributes: { style twoColumnListingLeft  });
	  add: (LWSingleContainer new 
	   child: rightComponent; 
	   containerElement: #div; 
	   containerAttributes: { style twoColumnListingRight }).
	self add: c.
	^ self 
]

{ #category : #'component lifecycle' }
LWTwoColumnListing >> mount [
   self containerElement: #div.
	self containerAttributes: style twoColumnListing
]

{ #category : #accessing }
LWTwoColumnListing >> style: anObject [

	style := anObject
]
