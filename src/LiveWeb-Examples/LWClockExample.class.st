Class {
	#name : #LWClockExample,
	#superclass : #LWComponent,
	#instVars : [
		'analog',
		'digital',
		'process'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #accessing }
LWClockExample >> children [
	^ ReadStream on: { analog . digital }
]

{ #category : #initialization }
LWClockExample >> initialize [
	super initialize.
	analog := LWSwitch new child: LWAnalogClock new; on.
	digital := LWSwitch new child: LWDigitalClock new; off.
]

{ #category : #'component lifecycle' }
LWClockExample >> mount [ 
	| time |
	time := [ | t |
		t := Time now.
      digital child time: t.
		analog child time: t ].
	
	time value. "set time for first render"
	
	"start process to update every 500ms"
	process := [ 
		[ (Delay forMilliseconds: 500) wait. 
		  time value. ] repeat.
	] fork.

]

{ #category : #rendering }
LWClockExample >> renderOn: h [
	h div: [ 
		h div: [ h input: { #id->#analog. #type->#checkbox. #checked->analog isOn.
								  #onchange->[analog toggle] };
					  label: { #for->#analog } with: 'Show analog' ].
		h div: [ h input: { #id->#digital. #type->#checkbox. #checked->digital isOn.
								  #onchange->[digital toggle] };
						label: { #for->#digital } with: 'Show digital' ].
		h br.
		h div: { #style->'width:300px' } with: [ analog render: h ].
		digital render: h.
	]
]

{ #category : #'component lifecycle' }
LWClockExample >> unmount [ 
	process terminate.

]
