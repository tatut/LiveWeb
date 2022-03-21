Class {
	#name : #LWTemplateTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Core-Tests'
}

{ #category : #tests }
LWTemplateTest >> testTemplate [ 
	LWTemplate new template: [ :h | h div: [ h templateSlot: #first ] ].
	
]
