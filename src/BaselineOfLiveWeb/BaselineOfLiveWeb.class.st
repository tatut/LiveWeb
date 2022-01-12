Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		self core: spec.
 		spec 
		  package: 'LiveWeb-Examples' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ];
 		  group: 'default'  with: #('LiveWeb-Core' 'LiveWeb-Styling' );
		  group: 'examples' with: #('LiveWeb-Examples');
		  group: 'tests' with: #('LiveWeb-Core-Tests' 'LiveWeb-Styling-Tests')
	]
]

{ #category : #'as yet unclassified' }
BaselineOfLiveWeb >> core: spec [
  spec 
		package: 'LiveWeb-Core';
		package: 'LiveWeb-Styling' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ];
		package: 'LiveWeb-Styling-Tests' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ]
]
