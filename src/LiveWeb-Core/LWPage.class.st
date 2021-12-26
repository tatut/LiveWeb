"
I represent a page in a web application. 

The page is the main HTTP endpoint, and will respond with a full HTML page that includes
scripts required to setup live interaction.

The page subclass is responsible for creating the body component.
The page can optionally have a head component that can be used to inject other 
resources (like CSS and fonts).

"
Class {
	#name : #LWPage,
	#superclass : #ZnEntity,
	#instVars : [
		'ctx',
		'id',
		'args'
	],
	#classVars : [
		'currentPages'
	],
	#category : #'LiveWeb-Core'
}

{ #category : #'as yet unclassified' }
LWPage class >> clientConnectionScript [ 
	"Get a client connection script. 
	Initially copied from ripley project."
	^ 'window._lw = {
    connection: null,
    debug: false,
    preOpenQueue: [],
    type: "ws",
    connected: false,
    debounceTimeout: {},
    get: function(id) {
        return document.querySelector("[data-lw=''"+id+"'']");
    },
    send: function(id, args, debouncems) {
        if(this.debug) console.log("Sending id:", id, ", args: ", args);
        if(!this.connected) {
            this.preOpenQueue.push({id: id, args: args});
        } else {
            if(debouncems === undefined) {
                this._send(id,args);
            } else {
                var tid = this.debounceTimeout[id];
                if(tid !== undefined) {
                    window.clearTimeout(tid);
                }
                this.debounceTimeout[id] = window.setTimeout(
                    function() { _lw._send(id,args); },
                    debouncems
                );
            }
        }
    },
    _send: function(id,args) {
        if(this.type === "sse") {
            var l = window.location;
            fetch(l.protocol+"//"+l.host+this.cpath+"?id="+this.cid,
                  {method: "POST",
                   headers: {"Content-Type":"application/json"},
                   body: JSON.stringify([id].concat(args))})
        } else if(this.type === "ws") {
            let msg = id+":"+JSON.stringify(args);
            this.connection.send(msg);
        } else {
            console.err("Unknown connection type: ", this.type);
        }
    },
    onopen: function(e) {
        this.connected = true;
        let q = this.preOpenQueue;
        let c = this.connection;
        for(var i = 0; i<q.length; i++) {
            let cb = q[i];
            this.send(cb.id, cb.args);
        }
        // clear the array
        q.length = 0;
    },
    connect: function(path, id) {
        var l = window.location;
        if(this.type === "sse") {
            var url = l.protocol+"//"+l.host+path+"?id="+id;
            this.connection = new EventSource(url, {withCredentials:true});
            this.connection.onmessage = this.onmessage.bind(this);
            this.cid = id;
            this.cpath = path;
            this.connection.onopen = this.onopen.bind(this);
        } else if(this.type === "ws") {
            var url = (l.protocol=="https:"?"wss://":"ws://")+l.host+path+"?id="+id;
            this.connection = new WebSocket(url);
            this.connection.onmessage = this.onmessage.bind(this);
            this.connection.onopen = this.onopen.bind(this);
            this.connection.onclose = this.onclose.bind(this);
        } else {
            console.error("Unknown connection type: ", this.type);
        }
    },
    setAttr: function(elt, attr, value) {
        // set attributes, some are set as properties instead
        if(attr === "checked") {
            elt.checked = value!==null;
        } else if(elt.tagName === "INPUT" && attr === "value") {
            elt.value = value;
        } else if(attr === "class" && elt.hasAttribute("data-rl-class")) {
            // has static class + dynamic part
            elt.className = elt.getAttribute("data-rl-class") + " " + value;
        } else {
            if(value === null) {
                elt.removeAttribute(attr);
            } else {
                elt.setAttribute(attr,value);
            }
        }
    },
    onmessage: function(msg) {
        if(this.debug) console.log("Received:", msg);
        if(msg.data === "!") {
            // Appliation level PING
            this.connection.send("!");
        } else {
            var patches = JSON.parse(msg.data);
            var patchlen = patches.length;
            for(var p = 0; p < patchlen; p++) {
                var patch = patches[p];
                var id = patch[0];
                var elt = _lw.get(id);
                if(elt == null) {
                    console.error("Received content for non-existant element: ", id,
                                  "msg:", msg);
                } else {
                    var method = patch[1];
                    var payload = patch[2];
                    if(this.debug) console.log("elt: ", elt, "method: ", method, ", payload: ", payload);
						  switch(method) {  
                       case "R": _lw.R(elt,payload); break;
                       case "A": elt.innerHTML += payload; break;
                       case "P": elt.innerHTML = payload + elt.innerHTML; break;
                       case "D": elt.parentElement.removeChild(elt); break;
                       case "F": elt.insertAdjacentHTML("afterend",payload); break;
                       case "M": elt.insertAdjacentElement("afterend",_lw.get(payload)); break;
                       case "<": elt.parentElement.insertAdjacentElement("afterbegin",elt); break;
                       case ">": elt.parentElement.insertAdjacentElement("beforeend",elt); break;
                       case "@": for(var attr in payload) { _lw.setAttr(elt, attr, payload[attr]) }; break;
                       case "E": (new Function(payload)).call(elt); break;
                       case "+": /* add child at index */
                           elt.insertBefore(patch[3], elt.childNodes[patch[2]]); break;
						}
                }
            }
        }
    },
    onclose: function(evt) {
        // PENDING: reconnect needs server to not cleanup the connection
        // other solution is to reload page (should do only if reconnect
        // fails because server has discarded the live context)
        console.log("WebSocket connection closed", evt);

        // If application has added an global function with name "liveweb_disconnected"
        // then call that.
        let disconnected = window.liveweb_disconnected;
        if(typeof(disconnected) === "function") {
            disconnected();
        }
    },

    // helper for R patch method to work around SVG issues
    // PENDING: need similar fix for appends? try to generalize
    R: function(elt, withContent) {
        if(elt.namespaceURI === "http://www.w3.org/2000/svg") {
            // Some browsers (Safari at least) can''t use outerHTML
            // replace as method to patch SVG.
            var parent = elt.parentElement;
            var g = document.createElementNS(parent.namespaceURI, parent.tagName);
            g.innerHTML = withContent;
            elt.replaceWith(g.firstElementChild);
        } else {
            // Simple outerHTML change for HTML elements
            elt.outerHTML = withContent;
        }
        // if there were any scripts in the replaced content, evaluate them
        // we need to refetch the element from DOM after its outerHTML changd
        if(withContent.match(/<script/ig)) {
            let id = elt.getAttribute("data-rl");
            _lw.get(id).querySelectorAll("script").forEach( (script) => {
                eval(script.text+"")
            })
        }
    }
}

_lws = _lw.send.bind(_lw)
'
]

{ #category : #testing }
LWPage class >> designatedMimeType [ 
	^ nil

]

{ #category : #'instance creation' }
LWPage class >> for: aUUID [
	"get rendered page for given id"
	^ currentPages ifNil: nil ifNotNil: [ 
		currentPages at: aUUID ifAbsent: nil ]
]

{ #category : #'as yet unclassified' }
LWPage class >> registerPage: aPageInstance for: aUUID [
	currentPages ifNil: [ currentPages := Dictionary new. ].
	currentPages at: aUUID put: aPageInstance.
]

{ #category : #'as yet unclassified' }
LWPage class >> unregisterPage: uuid [
	"should unmount any components left over?"
	currentPages removeKey: uuid.
]

{ #category : #'API - accessing' }
LWPage >> body: args [
	"create the body LWComponent"
	SubclassResponsibility new signal: 'LWPage subclasses must implement body'
]

{ #category : #accessing }
LWPage >> ctx [

	^ ctx
]

{ #category : #testing }
LWPage >> designatedMimeType [ 
	^ nil

]

{ #category : #'API - accessing' }
LWPage >> head: args [
	"create the head LWComponent, by default returns nil"
	^ nil
]

{ #category : #accessing }
LWPage >> id [

	^ id
]

{ #category : #testing }
LWPage >> isEmpty [
	^ false
]

{ #category : #'as yet unclassified' }
LWPage >> readArguments: aZnRequest [
	"read incoming HTTP arguments that will be passed to head: and body: calls.
	By default returns the request as is."
	^ aZnRequest 
]

{ #category : #accessing }
LWPage >> value: req [
	id := UUIDGenerator next. 
	ctx := LWContext new.
	args := self readArguments: req.
	^ ZnResponse ok: self
]

{ #category : #writing }
LWPage >> writeOn: stream [
	| h head body |
	head := self head: args.
	body := self body: args.
	stream nextPutAll: '<!doctype html>'; nextPut: Character lf.
	h := HTMLRenderer on: stream.
	h ctx: ctx.
	h html: 
	[ h head: [ 
		"output JS to connect websocket"
		head ifNotNil: [ 
			head inContext: ctx.
			head render: h ].
	   ].
     h body: [ 
		body inContext: ctx.
		body render: h.
		
		ctx used ifTrue: [ 
			"if body render did cause some live elements, output connection script
			and register this page"
 			self class registerPage: self for: id. 
			h script: self class clientConnectionScript, '
				document.onload = _lw.connect("/__liveweb", "', id asString  ,'")'.
		]
	 ]
   ].

	stream close.

]
