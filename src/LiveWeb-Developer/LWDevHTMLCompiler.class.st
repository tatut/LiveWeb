"
I compile HTML into `renderOn:` methods.
I provide JS to convert an HTML DOM into JSON which can be compiled.

We don't parse HTML in Smalltalk, we just provide the JS that turns a DOM node into
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
	#category : #'LiveWeb-Developer'
}

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
