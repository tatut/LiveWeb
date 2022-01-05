Class {
	#name : #LWTestsheet,
	#superclass : #LWStylesheetProvider,
	#category : #'LiveWeb-Styling-Tests'
}

{ #category : #'as yet unclassified' }
LWTestsheet >> bigText: howBig [
	^ self style: [ :s | s fontSize: 10px * howBig ] named: 'big'
]

{ #category : #'as yet unclassified' }
LWTestsheet >> myContainer: dir background: bgCol margin: marg [ 
	^ self style: [ :s |
		s display: 'flex';
		  flexDirection: dir;
		  backgroundColor: bgCol;
		  margin: marg ]
]
