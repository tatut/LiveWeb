Class {
	#name : #LWClock,
	#superclass : #LWComponent,
	#instVars : [
		'process'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'component lifecycle' }
LWClock >> mount [ 
	process := [ 
		[ (Delay forMilliseconds: 500) wait. 
		  self changed ] repeat.
	] fork.

]

{ #category : #rendering }
LWClock >> renderOn: h [
	| t transform |
	t := Time now.
	transform := [ :deg | #transform->('rotate(<1p> 50 50)' expandMacrosWith: deg asFloat) ].
	h div: [  
		h svg: { #viewBox -> '0 0 100 100' }
		with: [  
			h circle: { #cx -> 50 . #cy -> 50 . #r -> 45. #style->'stroke-width: 2px; stroke: wheat;' }.
			h g: { #style->'stroke-width: 1px; fill: #333; stroke: #555;' } with: [ 
				h rect: { #x->48.5. #y->22.5. 
							 #width->5. #height->30. 
							 #rx->2.5. #ry->2.55.
							 transform value: (t hours % 12 * 30) + (t minutes / 2)  };
				  rect: { #x->48. #y->12.5. #width->3. #height->40. #rx->2. #ry->2.
							 transform value: (t minutes * 6) };
				  line: { #x1->50. #y1->50. #x2->50. #y2->16. #style->'stroke: #f55;'.
							 transform value: (t seconds * 6) }.
			]].
		h text: t print24.
	] 
]

{ #category : #'component lifecycle' }
LWClock >> unmount [ 
	process terminate.

]
