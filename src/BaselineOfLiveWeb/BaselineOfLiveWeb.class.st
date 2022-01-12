Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec 
		package: 'Zinc-WebSocket-Core' with: [ spec repository: 'github://svenvc/zinc' ];
		
 		package: 'LiveWeb-Core' with: [ spec requires: #('Zinc-WebSocket-Core') ];
		package: 'LiveWeb-Styling' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Styling-Tests' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
		package: 'LiveWeb-Examples' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
		group: 'default' with: #(core tests);
		group: 'core' with: #('LiveWeb-Core' 'LiveWeb-Styling');
		group: 'tests' with: #('LiveWeb-Core-Tests' 'LiveWeb-Styling-Tests');
		group: 'examples' with: #('LiveWeb-Examples')
		
	]
]
