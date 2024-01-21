Class {
	#name : #LWDevMain,
	#superclass : #LWComponent,
	#instVars : [
		'classView',
		'pkgView',
		'pkgListing',
		'splitMain',
		'splitListing',
		'spotterDialog',
		'export',
		'classMethodsView'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #accessing }
LWDevMain >> children [ 
 ^ ReadStream on: { export. splitMain. spotterDialog }

]

{ #category : #compiling }
LWDevMain >> compile: className side: side source: source [
	| target methodName cls |
	cls := self class environment at: className asSymbol .
	target := side = 'instance'
		          ifTrue: [ cls ]
		          ifFalse: [ cls class ].
	methodName := target compile: source.
	"FIXME: should listen to method announcement? should only change/add method that was compiled"
	"methods child: self createMethodListing ."
	(self methodsViewFor: className) 
	  update: side = 'instance' method: methodName.
	
]

{ #category : #initialization }
LWDevMain >> initialize [ 
 | classSplit |
  super initialize.
  export := LWExportJS new 
		export: #lwCompileMethod -> [ :cname :side :source | self compile: cname side: side source: source ].
   classView := LWDevClassView new.
   classMethodsView := LWDevClassMethodsView new.
   classSplit := SlSplitPanel new 
      attrAt: #style update: [ 'height: 95vh; overflow: hidden; '];
		start: classView;
		end: classMethodsView;
		vertical: true;
		position: 25.
   pkgView := (LWDevPackageView new onClassSelected: [ :c | self showClass: c ]).
   pkgListing := LWDevPackageMenu new pkgView: pkgView.
   splitListing := SlSplitPanel new 
		vertical: false;
		start: pkgListing;
		end: pkgView.
   splitMain := SlSplitPanel new 
		position: 33; "33% for pkg/class listings, rest for class view"
		vertical: false;
		start: splitListing;
		end: classSplit.
	spotterDialog := LWDevSpotter new 
		onClassSelected: [ :c | self showClass: c ].

]

{ #category : #'as yet unclassified' }
LWDevMain >> methodsViewFor: aClassName [ 
 "get the right tab when we support tabs"
 ^ classMethodsView 
]

{ #category : #rendering }
LWDevMain >> render: h [ 
	h div: { #class -> 'lwDevPanel' } 
	  with: [ 
			export render: h.
			spotterDialog render: h.
			splitMain render: h
	 ]
]

{ #category : #'tool controlling' }
LWDevMain >> showClass: c [
	classView cls: c. 
	classMethodsView cls: c.
	
]
