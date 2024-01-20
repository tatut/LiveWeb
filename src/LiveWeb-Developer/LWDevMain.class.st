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
		vertical: false;
		start: splitListing;
		end: classView.
	spotterDialog := SlDialog new 
		className: 'spotter';
		label: 'Jump to class';
		add: (LWBlockContainer new block: [ :h | h input: { #placeholder -> 'type classname part' } ]);
		yourself. 

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
