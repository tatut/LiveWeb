Class {
	#name : #DemoEntity,
	#superclass : #Object,
	#instVars : [
		'anInteger',
		'aFloat',
		'aBoolean',
		'aString',
		'aDate',
		'aTime',
		'aDateAndTime'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #persistence }
DemoEntity class >> reStoreDefinition [ 
	^ super reStoreDefinition 
		define: #anInteger as: Integer;
		define: #aFloat as: Float;
		define: #aBoolean as: Boolean;
		define: #aString as: String;
		define: #aDate as: Date;
		define: #aTime as: Time;
		define: #aDateAndTime as: DateAndTime.

]

{ #category : #accessing }
DemoEntity >> aBoolean [

	^ aBoolean
]

{ #category : #accessing }
DemoEntity >> aBoolean: anObject [

	aBoolean := anObject
]

{ #category : #accessing }
DemoEntity >> aDate [

	^ aDate
]

{ #category : #accessing }
DemoEntity >> aDate: anObject [

	aDate := anObject
]

{ #category : #accessing }
DemoEntity >> aDateAndTime [

	^ aDateAndTime
]

{ #category : #accessing }
DemoEntity >> aDateAndTime: anObject [

	aDateAndTime := anObject
]

{ #category : #accessing }
DemoEntity >> aFloat [

	^ aFloat
]

{ #category : #accessing }
DemoEntity >> aFloat: anObject [

	aFloat := anObject
]

{ #category : #accessing }
DemoEntity >> aString [

	^ aString
]

{ #category : #accessing }
DemoEntity >> aString: anObject [

	aString := anObject
]

{ #category : #accessing }
DemoEntity >> aTime [

	^ aTime
]

{ #category : #accessing }
DemoEntity >> aTime: anObject [

	aTime := anObject
]

{ #category : #accessing }
DemoEntity >> anInteger [

	^ anInteger
]

{ #category : #accessing }
DemoEntity >> anInteger: anObject [

	anInteger := anObject
]
