"
I represent an active WebSocket connection to a rendered page.
I handle the callbacks sent by the client browser and send updated
component HTML to the client.
"
Class {
	#name : #LWPageConnection,
	#superclass : #Object,
	#instVars : [
		'page',
		'ws'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #accessing }
LWPageConnection class >> value: request [
	"Connect WebSocket to a rendered page"
	| acceptKey page handler |
	acceptKey := ZnWebSocketUtils handshake: (request headers at: 'Sec-WebSocket-Key').
	
	page := LWPage for: (UUID fromString:  (request uri queryAt: #id) ).
	page ifNil: [ ^ ZnResponse statusCode: 404 ].	
	handler := self new page: page.
	
	^ ZnWebSocketResponse new
		statusLine: (ZnStatusLine code: 101);
		headers: (ZnHeaders defaultResponseHeaders
			at: 'Upgrade' put: 'websocket';
			at: 'Connection' put: 'Upgrade';
			at: 'Sec-WebSocket-Accept' put: acceptKey;
			yourself);
		continuation: [ :ws | handler run: ws ];
		yourself
		
]

{ #category : #accessing }
LWPageConnection >> callback: idAndArgs [
	| id args split cb |
	split := idAndArgs indexOf: $:.
	id := (idAndArgs copyFrom: 1 to: split) asNumber.
	args := STONJSON fromString: (idAndArgs allButFirst: split).
	cb := page ctx callbackFor: id.
	cb ifNil: [ 
		"fixme better logging? should disconnect if wrong callback called?"
		Transcript show: 'no such callback', id asString;cr. ]
		ifNotNil: [ cb valueWithArguments: args ]
]

{ #category : #'as yet unclassified' }
LWPageConnection >> componentChanged: component [
	| html |
	page ctx cleanup: component.
	html := (String streamContents: [:out |
		| h |
		h := HTMLRenderer on: out.
		h ctx: page ctx.
		component render: h
		]).
	
	Transcript show: 'this component changed:', component asString;cr.
	ws sendMessage: (STONJSON toString: { { component id asString . 'R' . html } })
]

{ #category : #accessing }
LWPageConnection >> page [

	^ page
]

{ #category : #accessing }
LWPageConnection >> page: anObject [

	page := anObject
]

{ #category : #running }
LWPageConnection >> run: aWebSocket [ 
	| removeChangeListener |
	ws := aWebSocket.
	Transcript show: 'yhdistetty ', ws asString; cr.
	removeChangeListener := page ctx listenToChanges: [ :c | self componentChanged: c ].
	
	[ ws runWith: [ :msg |
		"Transcript show: 'viestin sain: ', msg printString;cr."
		ws logGeneric: '<- ', msg printString.
		self callback: msg.
		"ws sendMessage: message" ]] 
	on: ConnectionClosed 
	do: [ 
		Transcript show: 'Page disconnected'.
		removeChangeListener value.
		LWPage unregisterPage: page id.
	].

]
