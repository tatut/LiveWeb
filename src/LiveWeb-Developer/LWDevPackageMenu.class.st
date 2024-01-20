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
  ^ Smalltalk packages sorted.
  
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
