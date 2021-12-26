"
A HTMLRendererTest is a test class for testing the behavior of HTMLRenderer
"
Class {
	#name : #HTMLRendererTest,
	#superclass : #TestCase,
	#category : #'LiveWeb-Core-Tests'
}

{ #category : #'instance creation' }
HTMLRendererTest >> html: block [
	^ String streamContents: [:out | block value: (HTMLRenderer on: out) ]
]

{ #category : #tests }
HTMLRendererTest >> testAttributes [
   "attributes can be an array of associations"
	self assert: (self html: [:h |
		h div: { #id -> 'foo' . #style -> 'display: none;' }
			with: 'content'
		])
		equals: '<div id="foo" style="display: none;">content</div>'.
		
	"or a dictionary"
	self assert: (self html: [:h |
		h div: (Dictionary newFromAssociations: { #class -> 'foo' }) with: 'content'
		])
		equals: '<div class="foo">content</div>'
]

{ #category : #tests }
HTMLRendererTest >> testComponentId [
	"content block without arguments (use the same renderer)"
	self assert: (self html: [:h |
		h id: 42.
		h div: 'hello'
		])
		equals: '<div data-lw="42">hello</div>'.
	
	self assert: (self html: [:h |
		h id: 123.
		h div: [ h div: 'inner' ]])
		equals: '<div data-lw="123"><div>inner</div></div>'.
		
	self assert: (self html: [:h |
		h id: 0.
		h div: { #id -> 'foobar' } with: 'content'])
		equals: '<div data-lw="0" id="foobar">content</div>'.
 
]

{ #category : #tests }
HTMLRendererTest >> testContentBlock [
	"content block without arguments (use the same renderer)"
	self assert: (self html: [:h |
		h ul: [ 
			1 to: 3 do: [ :i |
				h li: { #class -> (i even ifTrue: 'even' ifFalse: 'odd') }
				  with: i
			]]
		])
		equals: '<ul><li class="odd">1</li><li class="even">2</li><li class="odd">3</li></ul>'.
	
 	"content block with 1 argument (the renderer)"
	self assert: (self html: [:h |
		h div: [ :r | r a: { #href -> 'http://example.com' } with: 'click' ]
		])
		equals: '<div><a href="http://example.com">click</a></div>'
]

{ #category : #tests }
HTMLRendererTest >> testSimpleHtmlContent [
	self assert: (self html: [:h |
		h div: 'Hello'
		])
		equals: '<div>Hello</div>'
]
