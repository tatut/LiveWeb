Class {
	#name : #BaselineOfLiveWeb,
	#superclass : #BaselineOf,
	#category : #BaselineOfLiveWeb
}

{ #category : #baselines }
BaselineOfLiveWeb >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec 
				package: 'LiveWeb-Core';
				package: 'LiveWeb-Core-Tests' with: [ spec requires: #('LiveWeb-Core') ]
		]
]
