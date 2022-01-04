Class {
	#name : #LWStyle,
	#superclass : #Object,
	#category : #'LiveWeb-Styling'
}

{ #category : #'as yet unclassified' }
LWStyle >> cssClassName [
	^ String streamContents: [ :out |
		"ouput class name and dash"
		out nextPutAll: self class asString.
		out nextPut: $-. 
		"output all instance variables order"
		self class instanceVariables do: [ :v |
			| val | 
			val := v value read: self.
			out nextPut: $–.
			out nextPutAll: val asString. "FIXME: need to clean it up for CSS name"
		]
	]
]
