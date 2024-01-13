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
	oneFifth: (LWDevPackageMenu new pkgView: pkgView);
	oneFifth: pkgView;
	threeFifths: (view box add: classView; yourself).
  
]
