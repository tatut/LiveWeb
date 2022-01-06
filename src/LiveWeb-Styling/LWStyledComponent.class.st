"
I am a very simple subclass of LWComponent. I only provide a method to access
the stylesheet provider from context.
"
Class {
	#name : #LWStyledComponent,
	#superclass : #LWComponent,
	#category : #'LiveWeb-Styling'
}

{ #category : #accessing }
LWStyledComponent >> style [ 
	^ ctx at: #stylesheetProvider

]
