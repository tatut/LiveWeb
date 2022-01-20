Extension { #name : #Number }

{ #category : #'*LiveWeb-Styling' }
Number >> asCSSPropertyValue [ 
	^ self asString
]

{ #category : #'*LiveWeb-Styling' }
Number >> asCSSPropertyValueNested [ 
	^ self asCSSPropertyValue 
]

{ #category : #'*LiveWeb-Styling' }
Number >> cm [
 ^ CSSValue of: self as: 'cm' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> em [
 ^ CSSValue of: self as: 'em' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> isCSSCalculated [ 
	^ false
]

{ #category : #'*LiveWeb-Styling' }
Number >> mm [
 ^ CSSValue of: self as: 'mm' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> pct [
	^ CSSValue of: self as: '%'
]

{ #category : #'*LiveWeb-Styling' }
Number >> px [
 ^ CSSValue of: self as: 'px' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> rem [
 ^ CSSValue of: self as: 'rem' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> vh [
 ^ CSSValue of: self as: 'vh' 
]

{ #category : #'*LiveWeb-Styling' }
Number >> vw [
 ^ CSSValue of: self as: 'vw' 
]
