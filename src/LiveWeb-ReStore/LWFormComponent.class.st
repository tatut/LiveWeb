"
I am the baseclass for components that can access an entity field. I do the access via parent form and accessor.

The configure field can be used to set a configuration block that will be called when this component is mounted.
The configure block will receive the page context and the object being configured.
"
Class {
	#name : #LWFormComponent,
	#superclass : #LWStyledComponent,
	#instVars : [
		'form',
		'accessor',
		'configure'
	],
	#category : #'LiveWeb-ReStore'
}

{ #category : #accessing }
LWFormComponent >> accessor [

	^ accessor
]

{ #category : #accessing }
LWFormComponent >> accessor: aFieldAccessorSymbol [
	accessor := aFieldAccessorSymbol 
]

{ #category : #accessing }
LWFormComponent >> configure: aConfigurationBlock [
	"Set the configuration block to call when mounting. Block will receive the object being configured 
	as the only argument.
	
	If there already is a configuration block present, the block is wrapped with the existing one.
	The configurations will be called in order they are added."
	configure 
		ifNil: [	configure := aConfigurationBlock ]
		ifNotNil: [ 
			| oldConfigure |
			oldConfigure := configure.
			configure := [ :obj | 
				oldConfigure value: obj.
				aConfigurationBlock value: obj ]]
]

{ #category : #accessing }
LWFormComponent >> form [

	^ form
]

{ #category : #accessing }
LWFormComponent >> form: anLWEditForm [
	form := anLWEditForm 
]

{ #category : #accessing }
LWFormComponent >> messages [
	"answer with the LWFormMessages instance in context"
	^ ctx at: #formMessages
]

{ #category : #'component lifecycle' }
LWFormComponent >> mount [
	"Run any configuration if configuration block is set. This should be called by subclasses
	after other setup has been done."
	configure ifNotNil: [ configure value: self ]
]
