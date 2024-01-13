"
I am a simple SVG clock.

When mounted, start a process to repeatedly signal changes to rerender the component.
The process is terminated when the component is unmounted.
"
Class {
	#name : #LWAnalogClock,
	#superclass : #LWClock,
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWAnalogClock >> exampleThreeOClock [ 
 <lwExample: 'Show a clock at 7 minutes and 20 seconds past 3 o''clock'>
 ^ self class new 
    time: (Time hour: 15 minute: 7 second: 20)
 
]

{ #category : #rendering }
LWAnalogClock >> renderOn: h [
	| transform |
	transform := [ :deg | #transform->('rotate(<1p> 50 50)' expandMacrosWith: deg asFloat) ].
	h div: [  
		h svg: { #viewBox -> '0 0 100 100' }
		with: [  
			h circle: { #cx -> 50 . #cy -> 50 . #r -> 45. self style clockFace  }.
			h g: { self style clockHands } with: [ 
				h rect: { #x->48.5. #y->22.5. 
							 #width->5. #height->30. 
							 #rx->2.5. #ry->2.55.
							 transform value: (time hours % 12 * 30) + (time minutes / 2)  };
				  rect: { #x->48. #y->12.5. #width->3. #height->40. #rx->2. #ry->2.
							 transform value: (time minutes * 6) };
				  line: { #x1->50. #y1->50. #x2->50. #y2->16. #style->'stroke: #f55;'.
							 transform value: (time seconds * 6) }.
			]].
	] 
]
