Class {
	#name : #SlButton,
	#superclass : #SlElement,
	#category : #'LiveWeb-Shoelace'
}

{ #category : #'as yet unclassified' }
SlButton class >> elementAttributes [ 
^#( 
 (variant (default primary success neutral warning danger text))
 (size (small medium large))
 (caret boolean)
 (disabled boolean)
 (loading boolean) 
 (outline boolean)
 (pill boolean) 
 (circle boolean)
 (type (button submit reset))
 (name string)
 (value string) 
 (href string) 
 (target (_blank _parent _self _top))
 (rel string)
 (download string)
 (form string) 

 "Probably not needed, as we don't do regular forms posts usually"
 (formaction string)
 (formenctype string)
 (formmethod string)
 (formnovalidate string)
 (formtarget string)
 
)
]

{ #category : #'as yet unclassified' }
SlButton class >> elementSlots [ 
 ^#(prefix suffix)
]

{ #category : #'as yet unclassified' }
SlButton >> caret [
		^ self attrAt: 'caret'
]

{ #category : #'as yet unclassified' }
SlButton >> caret: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'caret' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> circle [
		^ self attrAt: 'circle'
]

{ #category : #'as yet unclassified' }
SlButton >> circle: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'circle' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> disabled [
		^ self attrAt: 'disabled'
]

{ #category : #'as yet unclassified' }
SlButton >> disabled: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'disabled' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> download [
		^ self attrAt: 'download'
]

{ #category : #'as yet unclassified' }
SlButton >> download: newValue [
		self assert: newValue isString.
		self attrAt: 'download' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> form [
		^ self attrAt: 'form'
]

{ #category : #'as yet unclassified' }
SlButton >> form: newValue [
		self assert: newValue isString.
		self attrAt: 'form' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> formaction [
		^ self attrAt: 'formaction'
]

{ #category : #'as yet unclassified' }
SlButton >> formaction: newValue [
		self assert: newValue isString.
		self attrAt: 'formaction' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> formenctype [
		^ self attrAt: 'formenctype'
]

{ #category : #'as yet unclassified' }
SlButton >> formenctype: newValue [
		self assert: newValue isString.
		self attrAt: 'formenctype' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> formmethod [
		^ self attrAt: 'formmethod'
]

{ #category : #'as yet unclassified' }
SlButton >> formmethod: newValue [
		self assert: newValue isString.
		self attrAt: 'formmethod' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> formnovalidate [
		^ self attrAt: 'formnovalidate'
]

{ #category : #'as yet unclassified' }
SlButton >> formnovalidate: newValue [
		self assert: newValue isString.
		self attrAt: 'formnovalidate' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> formtarget [
		^ self attrAt: 'formtarget'
]

{ #category : #'as yet unclassified' }
SlButton >> formtarget: newValue [
		self assert: newValue isString.
		self attrAt: 'formtarget' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> href [
		^ self attrAt: 'href'
]

{ #category : #'as yet unclassified' }
SlButton >> href: newValue [
		self assert: newValue isString.
		self attrAt: 'href' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> loading [
		^ self attrAt: 'loading'
]

{ #category : #'as yet unclassified' }
SlButton >> loading: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'loading' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> name [
		^ self attrAt: 'name'
]

{ #category : #'as yet unclassified' }
SlButton >> name: newValue [
		self assert: newValue isString.
		self attrAt: 'name' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> outline [
		^ self attrAt: 'outline'
]

{ #category : #'as yet unclassified' }
SlButton >> outline: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'outline' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> pill [
		^ self attrAt: 'pill'
]

{ #category : #'as yet unclassified' }
SlButton >> pill: newValue [
		self assert: (newValue isKindOf: Boolean).
		self attrAt: 'pill' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> prefix [
		^ self slotAt: 'prefix'.
]

{ #category : #'as yet unclassified' }
SlButton >> prefix: aComponentOrString [
		self slotAt: 'prefix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlButton >> rel [
		^ self attrAt: 'rel'
]

{ #category : #'as yet unclassified' }
SlButton >> rel: newValue [
		self assert: newValue isString.
		self attrAt: 'rel' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> size [
		^ self attrAt: 'size'
]

{ #category : #'as yet unclassified' }
SlButton >> size: newValue [
		self assert: ( #( 'small' 'medium' 'large' ) includes: newValue).
		self attrAt: 'size' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> suffix [
		^ self slotAt: 'suffix'.
]

{ #category : #'as yet unclassified' }
SlButton >> suffix: aComponentOrString [
		self slotAt: 'suffix' put: (self asSlotComponent: aComponentOrString).
]

{ #category : #'as yet unclassified' }
SlButton >> target [
		^ self attrAt: 'target'
]

{ #category : #'as yet unclassified' }
SlButton >> target: newValue [
		self assert: ( #( '_blank' '_parent' '_self' '_top' ) includes: newValue).
		self attrAt: 'target' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> type [
		^ self attrAt: 'type'
]

{ #category : #'as yet unclassified' }
SlButton >> type: newValue [
		self assert: ( #( 'button' 'submit' 'reset' ) includes: newValue).
		self attrAt: 'type' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> value [
		^ self attrAt: 'value'
]

{ #category : #'as yet unclassified' }
SlButton >> value: newValue [
		self assert: newValue isString.
		self attrAt: 'value' update: [ newValue ]
]

{ #category : #'as yet unclassified' }
SlButton >> variant [
		^ self attrAt: 'variant'
]

{ #category : #'as yet unclassified' }
SlButton >> variant: newValue [
		self assert: ( #( 'default' 'primary' 'success' 'neutral' 'warning' 'danger' 'text' ) includes: newValue).
		self attrAt: 'variant' update: [ newValue ]
]
