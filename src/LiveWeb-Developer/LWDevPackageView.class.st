Class {
	#name : #LWDevPackageView,
	#superclass : #LWDevListing,
	#instVars : [
		'package',
		'classView'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevPackageView >> classView: aClassView [
  classView := aClassView
]

{ #category : #accessing }
LWDevPackageView >> items [ 
 package ifNil: [ ^ OrderedCollection empty ].
 "filter by name"
 ^ package classes sorted: [ :a :b | a name < b name ]. 
]

{ #category : #accessing }
LWDevPackageView >> label [ 
 ^ 'Classes'

]

{ #category : #accessing }
LWDevPackageView >> package: pkg [
	package := pkg.
	listing changed
]

{ #category : #enumerating }
LWDevPackageView >> select: className [ 
	classView cls: (package classes detect: [ :c | c name = className ])
]
