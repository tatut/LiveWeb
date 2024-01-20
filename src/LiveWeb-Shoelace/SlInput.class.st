Class {
	#name : #SlInput,
	#superclass : #SlFormField,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlInput class >> elementAttributes [ 
 ^ #( 
 (type (date 'datetime-local' email number password search tel text time url))
 (filled boolean)
 (pill boolean)
 (clearable boolean)
 (placeholder string)
 ('password-toggle' boolean)
 ('password-visible' boolean)
 ('no-spin-buttons' boolean)
 (pattern string)
 (minlength number)
 (maxlength number)
 (min number_or_string)
 (max number_or_string)
 (step number_or_any)
 (autocapitalize (off none on sentences words characters))
 (autocorrect (off on))
 (autocomplete string)
 (autofocus boolean)
 (enterkeyhint (enter done go next previous search send))
 (spellcheck boolean)
 (inputmode (none text decimal numeric tel search email url))
 
)
]

{ #category : #'as yet unclassified' }
SlInput class >> elementSlots [ 
 ^#( label prefix suffix 'clear-icon' 'show-password-icon' 'hide-password-icon' 'help-text' )

]

{ #category : #'as yet unclassified' }
SlInput >> autocapitalize [
		^ self attrAt: 'autocapitalize'
]

{ #category : #'as yet unclassified' }
SlInput >> autocapitalize: newValue [
		self assert: ( #( 'off' 'none' 'on' 'sentences' 'words' 'characters' ) includes: newValue).
		self attrAt: 'autocapitalize' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> autocomplete [
		^ self attrAt: 'autocomplete'
]

{ #category : #'as yet unclassified' }
SlInput >> autocomplete: newValue [
		self assert: newValue isString.
		self attrAt: 'autocomplete' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> autocorrect [
		^ self attrAt: 'autocorrect'
]

{ #category : #'as yet unclassified' }
SlInput >> autocorrect: newValue [
		self assert: ( #( 'off' 'on' ) includes: newValue).
		self attrAt: 'autocorrect' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> autofocus [
		^ self attrAt: 'autofocus'
]

{ #category : #'as yet unclassified' }
SlInput >> autofocus: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'autofocus' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> clearIcon [
		^ self slotAt: 'clear-icon'.
]

{ #category : #'as yet unclassified' }
SlInput >> clearIcon: aComponentOrString [
		self slotAt: 'clear-icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> clearable [
		^ self attrAt: 'clearable'
]

{ #category : #'as yet unclassified' }
SlInput >> clearable: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'clearable' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> enterkeyhint [
		^ self attrAt: 'enterkeyhint'
]

{ #category : #'as yet unclassified' }
SlInput >> enterkeyhint: newValue [
		self assert: ( #( 'enter' 'done' 'go' 'next' 'previous' 'search' 'send' ) includes: newValue).
		self attrAt: 'enterkeyhint' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> filled [
		^ self attrAt: 'filled'
]

{ #category : #'as yet unclassified' }
SlInput >> filled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'filled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> helpText [
		^ self slotAt: 'help-text'.
]

{ #category : #'as yet unclassified' }
SlInput >> helpText: aComponentOrString [
		self slotAt: 'help-text' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> hidePasswordIcon [
		^ self slotAt: 'hide-password-icon'.
]

{ #category : #'as yet unclassified' }
SlInput >> hidePasswordIcon: aComponentOrString [
		self slotAt: 'hide-password-icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> inputmode [
		^ self attrAt: 'inputmode'
]

{ #category : #'as yet unclassified' }
SlInput >> inputmode: newValue [
		self assert: ( #( 'none' 'text' 'decimal' 'numeric' 'tel' 'search' 'email' 'url' ) includes: newValue).
		self attrAt: 'inputmode' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> label [
		^ self slotAt: 'label'.
]

{ #category : #'as yet unclassified' }
SlInput >> label: aComponentOrString [
		self slotAt: 'label' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> max [
		^ self attrAt: 'max'
]

{ #category : #'as yet unclassified' }
SlInput >> max: newValue [
		
		self attrAt: 'max' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> maxlength [
		^ self attrAt: 'maxlength'
]

{ #category : #'as yet unclassified' }
SlInput >> maxlength: newValue [
		self assert: newValue isNumber.
		self attrAt: 'maxlength' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> min [
		^ self attrAt: 'min'
]

{ #category : #'as yet unclassified' }
SlInput >> min: newValue [
		
		self attrAt: 'min' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> minlength [
		^ self attrAt: 'minlength'
]

{ #category : #'as yet unclassified' }
SlInput >> minlength: newValue [
		self assert: newValue isNumber.
		self attrAt: 'minlength' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> noSpinButtons [
		^ self attrAt: 'no-spin-buttons'
]

{ #category : #'as yet unclassified' }
SlInput >> noSpinButtons: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'no-spin-buttons' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> passwordToggle [
		^ self attrAt: 'password-toggle'
]

{ #category : #'as yet unclassified' }
SlInput >> passwordToggle: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'password-toggle' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> passwordVisible [
		^ self attrAt: 'password-visible'
]

{ #category : #'as yet unclassified' }
SlInput >> passwordVisible: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'password-visible' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> pattern [
		^ self attrAt: 'pattern'
]

{ #category : #'as yet unclassified' }
SlInput >> pattern: newValue [
		self assert: newValue isString.
		self attrAt: 'pattern' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> pill [
		^ self attrAt: 'pill'
]

{ #category : #'as yet unclassified' }
SlInput >> pill: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pill' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> placeholder [
		^ self attrAt: 'placeholder'
]

{ #category : #'as yet unclassified' }
SlInput >> placeholder: newValue [
		self assert: newValue isString.
		self attrAt: 'placeholder' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> prefix [
		^ self slotAt: 'prefix'.
]

{ #category : #'as yet unclassified' }
SlInput >> prefix: aComponentOrString [
		self slotAt: 'prefix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> showPasswordIcon [
		^ self slotAt: 'show-password-icon'.
]

{ #category : #'as yet unclassified' }
SlInput >> showPasswordIcon: aComponentOrString [
		self slotAt: 'show-password-icon' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> spellcheck [
		^ self attrAt: 'spellcheck'
]

{ #category : #'as yet unclassified' }
SlInput >> spellcheck: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'spellcheck' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> step [
		^ self attrAt: 'step'
]

{ #category : #'as yet unclassified' }
SlInput >> step: newValue [
		
		self attrAt: 'step' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlInput >> suffix [
		^ self slotAt: 'suffix'.
]

{ #category : #'as yet unclassified' }
SlInput >> suffix: aComponentOrString [
		self slotAt: 'suffix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlInput >> type [
		^ self attrAt: 'type'
]

{ #category : #'as yet unclassified' }
SlInput >> type: newValue [
		self assert: ( #( 'date' 'datetime-local' 'email' 'number' 'password' 'search' 'tel' 'text' 'time' 'url' ) includes: newValue).
		self attrAt: 'type' update: [ newValue ]
]
