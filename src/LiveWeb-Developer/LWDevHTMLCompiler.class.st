"
I compile HTML into `renderOn:` methods.
I provide JS to convert an HTML DOM into JSON which can be compiled.

I don't parse HTML in Smalltalk, I just provide the JS that turns a DOM node into
JSON. 

A DOM element like:
  <div id=""foo"" class=""bar"">something <strong>here</strong></div>
is turned into JSON as:
  [""div"", {""id"": ""foo"", ""class"": ""bar}, ""something "", [""strong"", {}, ""here""]]

So [tag, attrs, ...content] where attrs is always an object, even if the element
has no attributes. After tag and attrs, the rest of the elements are its children
which can be other elements or strings.
"
Class {
	#name : #LWDevHTMLCompiler,
	#superclass : #Object,
	#instVars : [
		'rendererName',
		'code'
	],
	#category : #'LiveWeb-Developer'
}

{ #category : #compiling }
LWDevHTMLCompiler class >> compile: parsedHtml rendererName: rendererName [ 
	^ self new 
		rendererName: rendererName;
		compile: parsedHtml 
]

{ #category : #'as yet unclassified' }
LWDevHTMLCompiler class >> htmlToJsonScript [ 
 "JavaScript code to JSONify a DOM node"
 ^ '
function htmlToJsonWalk(elt) {
  if(elt.nodeName == "#text") { 
    return elt.nodeValue;
  } else { 
    let json = [ elt.tagName ];
    let attrs = { };
    elt.getAttributeNames().forEach(a=>{
      attrs[a] = elt.getAttribute(a)
    });
    json.push(attrs);
    let cs = elt.childNodes; 
    for(let i=0; i<cs.length; i++) json.push(htmlToJsonWalk(cs[i]));
    return json;
  }
}
function htmlToJson(str) { 
  let tpl = document.createElement("template");
  tpl.innerHTML = str;
  return {src: str, parsed: htmlToJsonWalk(tpl.content.children[0])};
}
'
]

{ #category : #testing }
LWDevHTMLCompiler class >> isHTMLMethod: m [
  "Check if the given method is an HTML method."
  (m pragmaAt: 'lwHTML:') isNotNil
]

{ #category : #compiling }
LWDevHTMLCompiler >> compile: parsedHtml [ 
 ^String streamContents: [ :c |
	 code := c.
	 self compileTag: parsedHtml ]
]

{ #category : #compiling }
LWDevHTMLCompiler >> compileAttr: attrCode [
	"Compile attribute, returns code for the attribute value."
	| blocks |
	blocks := self splitMustache: attrCode.
	"If there is only 1 block, return that as is."
	blocks size = 1 ifTrue: [ ^ blocks first ].
	"If there are multiple blocks, emit code to append string."
	^ String streamContents: [ :out |
			out << '(String streamContents: [ :__lw_attr | '.
			blocks do: [ :b | out << '__lw_attr << ('; << b; << '). ' ].
			out << '])'.
	 ].		 
]

{ #category : #compiling }
LWDevHTMLCompiler >> compileContent: content [
	(self splitMustache: content) do: [ :block |
		code << rendererName; <<' renderContent: ('; << block; << ').'; cr.
	].

]

{ #category : #compiling }
LWDevHTMLCompiler >> compileRepeat: lwRepeat tag: tagName attrs: tagAttrs with: content [ 
 | binding idx |
 "split on first space to separate binding name and code for collection, eg. x items "
 binding := lwRepeat splitOnFirst: $ .
 idx := tagAttrs removeKey: 'lw:index' ifAbsent: [ '__lw_index' ].
 code << '('; << binding second; << ') doWithIndex: [ :'; << binding first; << ' :'; << idx; << ' | ';cr.
 self compileTag: tagName attrs: tagAttrs with: content.
 code << '].'; cr.
 ^ true
]

{ #category : #compiling }
LWDevHTMLCompiler >> compileSpecial: tagName attrs: tagAttrs with: content [ 
 #( ('lw:repeat' compileRepeat:tag:attrs:with:) ) do: [ :attrAndMethod |
	tagAttrs 
	  at: attrAndMethod first 
	  ifPresent: [ :val | ^ self perform: attrAndMethod second 
		   with: val
			with: tagName
			with: (tagAttrs removeKey: attrAndMethod first; yourself)
		   with: content ]
	].
 "No special attribute was compiled, return false"	
 ^ false 

]

{ #category : #compiling }
LWDevHTMLCompiler >> compileTag: parsedTag [

	| tagName tagAttrs content |
	"If parsed tag is a string (content) output it via"
	parsedTag isString ifTrue: [
		self compileContent: parsedTag.
		^ nil ].

	"extract tag, attrs and content"
	tagName := parsedTag first asString asLowercase.
	tagAttrs := parsedTag second.
	content := parsedTag allButFirst: 2.

	"handle any special tags, like lw:repeat to repeat the element for each binding"
	self compileTag: tagName attrs: tagAttrs with: content
]

{ #category : #compiling }
LWDevHTMLCompiler >> compileTag: tagName attrs: tagAttrs with: content [
	"Check for special tag lw:repeat which repeats this tag"
	(self compileSpecial: tagName attrs: tagAttrs with: content) ifTrue: [ ^ nil ].
	code
		<< rendererName;
		<< ' ';
		<< tagName;
		<< ': { '.
	tagAttrs associationsDo: [ :attr |
		code
			<< ''''; << attr key; << ''' -> ';
			<< (self compileAttr: attr value);
			<< ' ' ].
	code << ' } with: [ '.
	content do: [ :c | self compileTag: c ].
	code
		<< '].';
		cr
]

{ #category : #accessing }
LWDevHTMLCompiler >> rendererName: name [
 rendererName  := name.
]

{ #category : #compiling }
LWDevHTMLCompiler >> splitMustache: text [
	"Split text that may contain mustache blocks {{ code }} and return an ordered collection 
	of the text/code sections. Text sections are returned as strings surrounded by quotes and code
	is returned as is."
	| codeStart codeEnd blocks |
	text isEmpty ifTrue: [ ^ OrderedCollection empty ].
	codeStart := text indexOfSubCollection: '{{'.
	codeStart = 0 ifTrue: [ 
		"no code blocks found, return attrCode as string value in code" 
		^ OrderedCollection new add: ('''{1}''' format: {text}); yourself
	].
   codeEnd := text indexOfSubCollection: '}}' startingAt: codeStart+2
		ifAbsent: [ Error signal: 'No ending }} found in code block' ].
	blocks := OrderedCollection new.
	"Add the text before the first code block, if any"
	codeStart > 0 ifTrue: [ blocks add: ('''{1}''' format: { text copyFrom: 1 to: codeStart-1 }) ].
	"Add the extracted code block"
	blocks add: (text copyFrom: codeStart+2 to: codeEnd-1).
	"Recursively handle text after code block"
	blocks addAll: (self splitMustache: (text allButFirst: codeEnd+1)).
	^ blocks
		 
]
