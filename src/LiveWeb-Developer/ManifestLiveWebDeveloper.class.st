"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestLiveWebDeveloper,
	#superclass : #PackageManifest,
	#category : #'LiveWeb-Developer-Manifest'
}

{ #category : #'code-critics' }
ManifestLiveWebDeveloper class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#LWDevClassExamplesView #updateExample #false)) #'2024-01-21T12:36:39.236663+02:00') )
]

{ #category : #'code-critics' }
ManifestLiveWebDeveloper class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#LWDevClassView #view: #false)) #'2024-01-13T15:28:17.828013+02:00') #(#(#RGPackageDefinition #(#'LiveWeb-Developer')) #'2024-01-13T15:56:33.362692+02:00') )
]
