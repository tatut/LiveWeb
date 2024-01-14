"
A LWContainerTest is a test class for testing the behavior of LWContainer
"
Class {
	#name : #LWContainerTest,
	#superclass : #LWComponentTest,
	#category : #'LiveWeb-Core-Tests'
}

{ #category : #tests }
LWContainerTest >> testAddAttribute [
 | c |
 c := LWContainer new containerElement: #div; containerAttributes: { #class -> 'foo' }.
 c attr: #style -> 'display: flex;'.
 self assert: (self render: c) equals: '<div data-lw="0" class="foo" style="display: flex;"></div>'

]

{ #category : #tests }
LWContainerTest >> testMountedAttributeChange [
 self assert: (self render: LWContainer new) equals: '<span data-lw="0"></span>'.
 component attr: 'data-foo' -> 420.
 self assert: self patches last equals: '@' -> { 'data-foo' -> 420 } asDictionary 
]

{ #category : #tests }
LWContainerTest >> testUpdateAttribute [ 
 | c |
 c := LWContainer new containerElement: #div; containerAttributes: { #class -> 'foo' }.
 c attr: #class update: [ :foo | foo, ' bar' ].
 self assert: (self render: c) equals: '<div data-lw="0" class="foo bar"></div>'
]
