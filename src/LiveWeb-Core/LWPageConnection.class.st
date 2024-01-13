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
		"PENDING: should disconnect if wrong callback called? client is confused"
		LWLogEvent warn: 'no such callback', id asString ]
		ifNotNil: [ cb valueWithArguments: args ]
]

{ #category : #'as yet unclassified' }
LWPageConnection >> component: parentComponent childAdded: newChildComponent at: index [
	| html p cc |
	html := self renderToString: newChildComponent.
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
		h := page htmlRenderer: out.
		h ctx: page ctx.
		component render: h
	].

]

{ #category : #'as yet unclassified' }
LWPageConnection >> rerenderComponent: component [
	[ page ctx cleanup: component unmount: false.
	  self send: { { component id asString . 'R' . self renderToString: component } } ]
	on: Exception  
	do: [ :e |
		LWLogEvent error: 'Error in component: ', component printString.
		ws close. ].
]

{ #category : #running }
LWPageConnection >> run: aWebSocket [ 
	ws := aWebSocket.
	page ctx connection: self. "set myself as the page context connection, for change notifications"
	
	[ ws runWith: [ :msg |
		LWLogEvent debug: '<- ', msg printString.
		self tryCallback: msg ]] 
	on: ConnectionClosed 
	do: [ 
		LWLogEvent debug: 'Page disconnected, id: ', page id asString.
		page ctx connectionClosed.
		LWPage unregisterPage: page id.
	].

]

{ #category : #instructions }
LWPageConnection >> send: patches [
	ws sendMessage: (STONJSON toString: patches)
]

{ #category : #'as yet unclassified' }
LWPageConnection >> tryCallback: message [ 
 [ self callback: message ]
 on: Error 
 do: [ :ex |
	LWLogEvent error: 'Error in callback processing: ', ex asString
 ]
]
