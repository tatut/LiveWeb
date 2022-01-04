Extension { #name : #Array }

{ #category : #'*LiveWeb-Styling' }
Array >> cssDeclarations [ 
	"convert an array of property->value associations into CSS declarations"			
	^ String streamContents: [ :out |
		self withIndexDo: [ :item :i |
			i > 1 ifTrue: [ out nextPutAll: '; ' ].
			out nextPutAll: item key asCSSPropertyName;
				 nextPut: $:;
				 nextPutAll: item value asCSSPropertyValue 
			 ]
		 ]
]
