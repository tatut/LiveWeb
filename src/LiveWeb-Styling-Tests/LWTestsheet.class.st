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
LWTestsheet >> flex: dir on: s [
	"helper to set flex style"
	s display: 'flex'; flexDirection: dir.
]

{ #category : #'as yet unclassified' }
LWTestsheet >> myContainer: dir background: bgCol margin: marg [ 
	^ self style: [ :s |
		self flex: dir on: s. 
		s backgroundColor: bgCol;
		  margin: marg ]
]
