Class {
	#name : #LWDevPage,
	#superclass : #LWBulmaPage,
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
		add: '
		 <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ace.min.js"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.23.1/ext-language_tools.min.js"></script>
       <script>function initEditor() {
        let e = window.event.target; 
        e.style.height = Math.max(100, e.clientHeight) + "px";
        let editor = ace.edit(e);
        editor.session.setMode("ace/mode/text");
        editor.setTheme("ace/theme/tomorrow");
        editor.resize();
       }
       </script>';
		yourself
		
]
