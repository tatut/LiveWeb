Class {
	#name : #LWDevMain,
	#superclass : #LWComponent,
	#instVars : [
		'classView',
		'pkgView',
		'pkgListing',
		'splitMain',
		'splitListing',
		'spotterDialog'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevMain >> children [ 
 ^ ReadStream on: { splitMain. spotterDialog }

]

{ #category : #initialization }
LWDevMain >> initialize [ 
  super initialize.
   classView := LWDevClassView new.
   pkgView := LWDevPackageView new classView: classView.
   pkgListing := LWDevPackageMenu new pkgView: pkgView.
   splitListing := SlSplitPanel new 
		vertical: false;
		start: pkgListing;
		end: pkgView.
   splitMain := SlSplitPanel new 
		position: 33; "33% for pkg/class listings, rest for class view"
		vertical: false;
		start: splitListing;
		end: classView.
	spotterDialog := LWDevSpotter new classView: classView.
	

]

{ #category : #rendering }
LWDevMain >> render: h [ 
	h div: { #class -> 'lwDevPanel' } 
	  with: [ 
			spotterDialog render: h.
			splitMain render: h
	 ]
]

{ #category : #accessing }
LWDevMain >> view: view [
 | pkgView classView |
 classView := LWDevClassView new.
 pkgView := LWDevPackageView new classView: classView.
 ^ view columns 
	add: (LWDevPackageMenu new pkgView: pkgView) sized: 2;
	add: pkgView sized: 2;
	auto: classView; yourself.
  
]
