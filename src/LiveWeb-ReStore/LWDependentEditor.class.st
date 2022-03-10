Class {
	#name : #LWDependentEditor,
	#superclass : #LWBaseEditor,
	#instVars : [
		'dependent',
		'childComponents'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWDependentEditor >> dependent: aDependentWrapper [
	"set the dependent wrapper definition to use"
	dependent := aDependentWrapper 
]
