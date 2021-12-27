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
LWPageConnection >> component: parentComponent childAdded: newChildComponent at: index [
	| html p cc |
	html := self renderToString: newChildComponent.
	"FIXME: we don't really use index..."
	p := parentComponent id asString.
	cc := parentComponent childCount.
	(index = cc) | (cc = 0)
		"added as last index or no children before, append to element"
		ifTrue: 	[ self send: { { p . 'A' . html } } ]
		ifFalse: [ 
			"added before last, insert before another child"
			self send: {{ p . '+' . index - 1 . html }}
			]

]

{ #category : #'as yet unclassified' }
LWPageConnection >> componentChanged: component [
	| html |
	page ctx cleanup: component.
	html := self renderToString: component.
	self send: { { component id asString . 'R' . html } }
]

{ #category : #accessing }
LWPageConnection >> page [

	^ page
]

{ #category : #accessing }
LWPageConnection >> page: anObject [

	page := anObject
]

{ #category : #rendering }
LWPageConnection >> renderToString: component [ 
	^ String streamContents: [:out |
		| h |
		h := HTMLRenderer on: out.
		h ctx: page ctx.
		component render: h
	].

]

{ #category : #running }
LWPageConnection >> run: aWebSocket [ 
	ws := aWebSocket.
	Transcript show: 'yhdistetty ', ws asString; cr.
	page ctx connection: self. "set myself as the page context connection, for change notifications"
	
	[ ws runWith: [ :msg |
		"Transcript show: 'viestin sain: ', msg printString;cr."
		ws logGeneric: '<- ', msg printString.
		self callback: msg.
		"ws sendMessage: message" ]] 
	on: ConnectionClosed 
	do: [ 
		Transcript show: 'Page disconnected'.
		page ctx connection: nil.
		LWPage unregisterPage: page id.
	].

]

{ #category : #instructions }
LWPageConnection >> send: patches [
	ws sendMessage: (STONJSON toString: patches)
]
