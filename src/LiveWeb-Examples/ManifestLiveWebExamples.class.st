"
Examples for LiveWeb.

To get started:
  
  >>> ZnServer startDefaultOn: 8080.
  >>> d := ZnServer default.
  >>> d delegate map: #counter to: (LWExamplePage of: LWMultiCounter).
  >>> d delegate map: '__liveweb' to: LWPageConnection.

And open http://localhost:8080/counter in a browser.

You can manipulate a running page from the playground (take the page id from 
browser network tab ws connection):

  >>> p := LWPage for: (UUID fromString: '87b38abc-6f90-0d00-843d-f006090a806e')
  >>> c := p ctx components at: 1
  >>> c counter: 420.

"
Class {
	#name : #ManifestLiveWebExamples,
	#superclass : #PackageManifest,
	#category : #'LiveWeb-Examples-Manifest'
}