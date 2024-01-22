Class {
	#name : #LWDevPage,
	#superclass : #SlLWPage,
	#category : #'LiveWeb-Developer'
}

{ #category : #displaying }
LWDevPage class >> installOn: server [
	server delegate map: 'dev' to: [ :req | self new value: req ].
]

{ #category : #'API - accessing' }
LWDevPage >> body: _args [
 ^ LWDevMain new
]

{ #category : #'API - accessing' }
LWDevPage >> head: _args [
	^ LWFragmentContainer new 
		add: (super head: _args);
		add: (String streamContents: [ :out | 
			out << '
			<style>
			.listing-menu-item::part(base) { font-size: 0.75rem; padding: 1px; }
			</style>
			
		 <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ace.min.js"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-language_tools.min.js"></script>
       <script>function initEditor() {
        const e = window.event.target; 
        if(e.tagName != "PRE" || e.classList.contains("ace_editor")) return;
console.log(e.classList);
        const side = e.dataset.side;
        const cls = e.dataset.class;
        e.style.height = Math.max(100, e.clientHeight) + "px";
        let editor = ace.edit(e);
        editor.session.setMode("ace/mode/text");
        editor.setTheme("ace/theme/tomorrow");
        editor.resize();
 		  editor.commands.addCommand({
			name: "save", 
			bindKey: {win: "Ctrl-s", mac: "Command-s"}, 
			exec: function(editor) { window.event.preventDefault(); lwCompileMethod(cls, side, editor.session.getValue()); },
         readOnly: true});
       }';
		<< (LWDevHTMLCompiler htmlToJsonScript);
		"Add shift+enter listener to open spotter"
		<< 'window.addEventListener("keydown", e => { 
           if(e.key=="Enter" && e.shiftKey) { 
           e.preventDefault(); e.stopPropagation();
		     let spotter = document.querySelector(".spotter");
		       spotter.setAttribute("open",true); 
		    }
		   }, {capture: true});';
		<< '</script>' ]);
		yourself
		
]
