Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec baseline: 'ZincHTTPComponents' with: [ spec repository: 'github://svenvc/zinc'; loads: 'Zinc-WebSocket-Core' ];
		 
		package: 'LiveWeb-Core';
		package: 'LiveWeb-Styling' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Styling-Tests' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
		group: 'default' with: #('LiveWeb-Core' 'LiveWeb-Styling');
		group: 'tests' with: #('LiveWeb-Core-Tests' 'LiveWeb-Styling-Tests');
		group: 'examples' with: #('LiveWeb-Examples')
		
	]
]

{ #category : #'as yet unclassified' }
BaselineOfLiveWeb >> core: spec [
  spec 
		package: 'LiveWeb-Core' with: [ spec requires: #('Zinc-WebSocket-Core') ];
		package: 'LiveWeb-Styling' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Styling-Tests' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ]
]

{ #category : #'as yet unclassified' }
BaselineOfLiveWeb >> examples: spec [
 spec
	package: 'LiveWeb-Examples' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ]

]
