Class {
	#name : #LWDevMain,
	#superclass : #LWBulmaComponent,
	#category : #'LiveWeb-Developer'
}

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
