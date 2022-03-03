Class {
	#name : #LWLogEvent,
	#superclass : #ZnLogEvent,
	#instVars : [
		'level',
		'message'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'accessing - structure variables' }
LWLogEvent class >> debug: message [
	self emitLevel: #DEBUG message: message.
]

{ #category : #'as yet unclassified' }
LWLogEvent class >> emitLevel: level message: message [
	self new level: level; message: message; emit
]

{ #category : #'accessing - structure variables' }
LWLogEvent class >> error: message [
	self emitLevel: #ERROR message: message.
]

{ #category : #'accessing - structure variables' }
LWLogEvent class >> info: message [
	self emitLevel: #INFO message: message.
]

{ #category : #'as yet unclassified' }
LWLogEvent class >> logToStdout [
	self stopLoggingToStdout.
	ZnLogEvent announcer when: ZnLogEvent do: [ :e | 
		| msg |
		msg := String streamContents: [:out | e printOn: out].
		Stdio stdout << msg; crlf; flush.
		]
]

{ #category : #'as yet unclassified' }
LWLogEvent class >> stopLoggingToStdout [
	ZnLogEvent announcer unsubscribe: self.
]

{ #category : #'accessing - structure variables' }
LWLogEvent class >> warn: message [
	self emitLevel: #WARN message: message.
]

{ #category : #accessing }
LWLogEvent >> level: anObject [

	level := anObject
]

{ #category : #accessing }
LWLogEvent >> message: anObject [

	message := anObject
]

{ #category : #printing }
LWLogEvent >> printContentsOn: stream [
	stream 
		<< ' [';
		<< level asString;
		<< '] ';
		<< message asString.
		
]
