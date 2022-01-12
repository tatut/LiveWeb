Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			self core: spec.
		];
		for: #examples do: [ 
			self core: spec.
			spec package: 'LiveWeb-Examples' with: [ spec requires: #('LiveWeb-Core' 'LiveWeb-Styling') ]
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
