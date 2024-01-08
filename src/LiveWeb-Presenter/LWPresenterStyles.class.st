Class {
	#name : #LWPresenterStyles,
	#superclass : #LWStylesheetProvider,
	#category : #'LiveWeb-Presenter'
}

{ #category : #'as yet unclassified' }
LWPresenterStyles >> twoColumnListing [ 
 ^ self style: [ :s | s display: #flex; flexDirection: #col ]
]

{ #category : #'as yet unclassified' }
LWPresenterStyles >> twoColumnListingLeft [ 
  ^ self style: [ :s | s fontWeight: #bold ]

]

{ #category : #'as yet unclassified' }
LWPresenterStyles >> twoColumnListingRight [ 
  ^ self empty

]

{ #category : #'as yet unclassified' }
LWPresenterStyles >> twoColumnListingRow [ 
  ^ self style: [ :s | s display: #flex; flexDirection: #row ]

]
