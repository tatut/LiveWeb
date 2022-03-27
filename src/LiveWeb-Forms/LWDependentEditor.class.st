Class {
	#name : #LWDependentEditor,
	#superclass : #LWBaseEditor,
	#instVars : [
		'dependent',
		'childComponents'
	],
	#category : #'LiveWeb-Forms'
}

{ #category : #accessing }
LWDependentEditor >> dependent: aDependentWrapper [
	"set the dependent wrapper definition to use"
	dependent := aDependentWrapper 
]
