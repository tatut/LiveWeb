Class {
	#name : #SlLWPage,
	#superclass : #LWPage,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlLWPage >> bodyAttributes: _args [ 
 self theme = 'dark' ifTrue: [ ^ { #class -> 'sl-theme-dark' } ].
 ^ #()
]

{ #category : #'API - accessing' }
SlLWPage >> head: _args [
 | css js |
 css := 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@{1}/cdn/themes/{2}.css' format: { self version. self theme }.
 js := 'https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.12.0/cdn/shoelace{1}.js' format: { 
	self useAutoloader ifTrue: [ '-autoloader' ] ifFalse: [ '' ] }.
	
 ^ LWBlockContainer new block: [ :h | 
	 	h link: { #rel -> 'stylesheet'. #href -> css };
		  script: { #type -> 'module'. #src -> js } with: ''.
		]
]

{ #category : #accessing }
SlLWPage >> theme [ 
 "Override to return 'dark' for dark theme"
 ^ 'light'
]

{ #category : #'as yet unclassified' }
SlLWPage >> useAutoloader [ 
 ^true

]

{ #category : #versions }
SlLWPage >> version [ 
 ^ '2.12.0'
]
