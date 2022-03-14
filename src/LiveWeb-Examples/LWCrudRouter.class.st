Class {
	#name : #LWCrudRouter,
	#superclass : #LWPushStateRouter,
	#category : #'LiveWeb-Examples'
}

{ #category : #initialization }
LWCrudRouter >> initialize [
	super initialize.
	self
		route: '/crud/:table' as: LWCrudListingState;
		route: '/crud/:table/create' as: LWCrudCreateState;
		route: '/crud/:table/:id' as: LWCrudEditState.
		
	
]
