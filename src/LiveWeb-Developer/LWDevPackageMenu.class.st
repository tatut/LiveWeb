Class {
	#name : #LWDevPackageMenu,
	#superclass : #LWDevListing,
	#instVars : [
		'pkgView'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #rendering }
LWDevPackageMenu >> items [
  | pkgs f |
  pkgs := Smalltalk packages sorted.
  filter isEmpty ifTrue: [ ^pkgs ].
  f := '*{1}*' format: { filter }.
  ^ pkgs select: [ :p | f match: p name  ]
]

{ #category : #accessing }
LWDevPackageMenu >> label [ 
 ^ 'Packages'
]

{ #category : #accessing }
LWDevPackageMenu >> pkgView: aPkgViewComponent [ 
 pkgView := aPkgViewComponent 
]

{ #category : #'browse-nautilus' }
LWDevPackageMenu >> select: pkg [
	pkgView package: (Smalltalk packages detect: [ :p | p name = pkg ])
]
