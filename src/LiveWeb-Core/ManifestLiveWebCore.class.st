"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLiveWebCore,
	#superclass : #PackageManifest,
	#category : #'LiveWeb-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestLiveWebCore class >> ruleEqualsTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#HTMLRenderer #renderAttrs: #false)) #'2024-01-17T16:42:52.579413+02:00') )
]
