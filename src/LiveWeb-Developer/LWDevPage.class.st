Class {
	#name : #LWDevPage,
	#superclass : #LWBulmaPage,
	#category : #'LiveWeb-Developer'
}

{ #category : #displaying }
LWDevPage class >> installOn: server [
	server delegate map: 'dev' to: [ :req | self new value: req ].
]

{ #category : #'API - accessing' }
LWDevPage >> body: _args [
 ^ LWDevMain new
]
