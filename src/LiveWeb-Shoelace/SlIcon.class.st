Class {
	#name : #SlIcon,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlIcon class >> elementAttributes [ 
^#(
 (name string)
 (src string)
 (label string)
 (library string)
)
]

{ #category : #'as yet unclassified' }
SlIcon class >> iconsExample [ 
 <lwExample: 'Icon test'>
	| input icon |
	^ LWContainer new 
		attr: #style -> 'font-size: 32px;';
		add: (input := SlInput new 
					placeholder: 'type icon name'; 
					on: SlInputEvent 
					do: (Js debounced: [:e | icon name: e value ] wait: (Duration milliSeconds: 500)));
		add: (icon := SlIcon new);
		add: (LWBlockContainer new block: [ :h | h div: [ h a: { #href -> 'https://shoelace.style/components/icon#default-icons' } with: 'see icons here' ]]);
		yourself
]

{ #category : #'as yet unclassified' }
SlIcon >> label [
		^ self attrAt: 'label'
]

{ #category : #'as yet unclassified' }
SlIcon >> label: newValue [
		self assert: newValue isString.
		self attrAt: 'label' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlIcon >> library [
		^ self attrAt: 'library'
]

{ #category : #'as yet unclassified' }
SlIcon >> library: newValue [
		self assert: newValue isString.
		self attrAt: 'library' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlIcon >> name [
		^ self attrAt: 'name'
]

{ #category : #'as yet unclassified' }
SlIcon >> name: newValue [
		self assert: newValue isString.
		self attrAt: 'name' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlIcon >> src [
		^ self attrAt: 'src'
]

{ #category : #'as yet unclassified' }
SlIcon >> src: newValue [
		self assert: newValue isString.
		self attrAt: 'src' update: [ newValue ]
]
