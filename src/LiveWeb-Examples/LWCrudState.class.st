Class {
	#name : #LWCrudState,
	#superclass : #LWPushStateBase,
	#instVars : [
		'table'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWCrudState >> table [

	^ table
]

{ #category : #accessing }
LWCrudState >> table: anObject [

	table := anObject
]

{ #category : #'as yet unclassified' }
LWCrudState >> tableClass [ 
	^ { #customer -> Customer. 
	    #address -> Address.
	    #order -> CustomerOrder.
	    #demo -> DemoEntity } asDictionary at: table 
]
