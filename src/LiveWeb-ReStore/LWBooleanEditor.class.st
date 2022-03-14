Class {
	#name : #LWBooleanEditor,
	#superclass : #LWBaseEditor,
	#category : #'LiveWeb-ReStore'
}

{ #category : #initialization }
LWBooleanEditor >> initialize [ 
	super initialize.
	showLabel := false.
]

{ #category : #rendering }
LWBooleanEditor >> renderInput: h hasError: err [
  h span: [ 
	h input: { 
		#type -> #checkbox.
		#checked -> self currentValue.
		#name -> accessor. 
     #id -> accessor. 
		#onchange -> (Js call: self setter with: (Js inputChecked: accessor)) };
		label: { #for -> accessor } with: (self messages fieldLabel: accessor)
	]
]
