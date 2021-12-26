"
I represent a page in a web application. 

The page is the main HTTP endpoint, and will respond with a full HTML page that includes
scripts required to setup live interaction.

The page subclass is responsible for creating the body component.
The page can optionally have a head component that can be used to inject other 
resources (like CSS and fonts).

"
Class {
	#name : #LWPage,
	#superclass : #Object,
	#category : #'LiveWeb-Core'
}

{ #category : #'API - accessing' }
LWPage >> body: args [
	"create the body LWComponent"
	SubclassResponsibility new signal: 'LWPage subclasses must implement body'
]

{ #category : #'API - accessing' }
LWPage >> head: args [
	"create the head LWComponent, by default returns nil"
	^ nil
]

{ #category : #'as yet unclassified' }
LWPage >> readArguments: aZnRequest [
	"read incoming HTTP arguments that will be passed to head: and body: calls.
	By default returns the request as is."
	^ aZnRequest 
]

{ #category : #accessing }
LWPage >> value: req [
	| ctx head body args |
	ctx := LWContext new.
	args := self readArguments: req.
	head := self head: args.
	body := self body: args.
	head ifNotNil: [ head inContext: ctx ]. 
	body inContext: ctx.
	^ ZnResponse ok: (LWPageEntity new head: head; body: body)
]
