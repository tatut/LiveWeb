Class {
	#name : #LWDevPackageView,
	#superclass : #LWDevListing,
	#instVars : [
		'package',
		'onClassSelected'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #'accessing - classes' }
LWDevPackageView >> classSelected: aClass [
 onClassSelected value: aClass
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
LWDevPackageView >> onClassSelected: aBlock [ 
 onClassSelected := aBlock 
]

{ #category : #accessing }
LWDevPackageView >> package: pkg [
	package := pkg.
	listing changed
]

{ #category : #enumerating }
LWDevPackageView >> select: className [ 
	self classSelected: (package classes detect: [ :c | c name = className ])
]
