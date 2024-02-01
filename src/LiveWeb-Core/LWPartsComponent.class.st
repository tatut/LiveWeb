"
I am a component that has multiple render methods, which each make up a child component.
This makes it convenient to have separately updatable child components, while keeping the rendering 
in the same class.

When initialized, I will create a dictionary of children that map selector to a newly created
LWBlockContainer component. Each child's render must output a single element.

Each child component render method must have an <lwPart> pragma attached.

There is no need to implement children method, it is automatic.

"
Class {
	#name : #LWPartsComponent,
	#superclass : #LWComponent,
	#instVars : [
		'parts'
	],
	#category : #'LiveWeb-Core'
}
