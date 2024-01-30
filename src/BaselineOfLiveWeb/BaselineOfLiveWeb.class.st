Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec for: #common do: [
		self reStore: spec.
		spec
		package: 'Zinc-WebSocket-Core' with: [ spec repository: 'github://svenvc/zinc' ];
 		package: 'LiveWeb-Core' with: [ spec requires: #('Zinc-WebSocket-Core') ];
		package: 'LiveWeb-Styling' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Styling-Tests' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
		package: 'LiveWeb-Bulma' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Examples' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling' 'LiveWeb-Forms' 'LiveWeb-Bulma' 'LiveWeb-ReStore') ];
		package: 'Pows-Core' with: [ spec repository: 'github://tatut/pharo-Pows' ];
      package: 'LiveWeb-Examples-Tests' with: [ spec requires: #('LiveWeb-Examples' 'Pows-Core') ];
 		package: 'LiveWeb-Shoelace' with: [ spec requires: #('LiveWeb-Core') ];
      package: 'LiveWeb-Developer' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Shoelace') ];
	   package: 'LiveWeb-Developer-Tests' with: [ spec requires: #('LiveWeb-Developer') ];
		package: 'LiveWeb-Forms' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
		package: 'LiveWeb-ReStore' with: [ spec requires: #('ReStore') ];
		group: 'default' with: #(core tests);
		group: 'core' with: #('LiveWeb-Core' 'LiveWeb-Styling');
		group: 'developer' with: #(core 'LiveWeb-Developer');
		group: 'tests' with: #('LiveWeb-Core-Tests' 'LiveWeb-Styling-Tests' 'LiveWeb-Developer-Tests');
		group: 'examples' with: #('core' 'LiveWeb-Examples');
      group: 'fulltests' with: #(core tests 'LiveWeb-Examples' 'LiveWeb-Examples-Tests')

	]
]

{ #category : #accessing }
BaselineOfLiveWeb >> reStore: spec [
	spec
		baseline: 'ReStore'
		with: [
			spec
				repository: 'github://rko281/ReStoreForPharo';
				loads: 'Examples'
		]
]
