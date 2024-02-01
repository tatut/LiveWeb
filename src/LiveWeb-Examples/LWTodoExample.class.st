Class {
	#name : #LWTodoExample,
	#superclass : #LWComponent,
	#instVars : [
		'items'
	],
	#category : #'LiveWeb-Examples'
}

{ #category : #'as yet unclassified' }
LWTodoExample class >> todoExample [
 <lwExample: 'Todo with some items'>
 ^ self new 
	item: (LWTodoItem new label: 'create example'; beComplete);
	item: (LWTodoItem new label: 'show changing HTML rendering');
	item: (LWTodoItem new label: 'profit!')
]

{ #category : #initialization }
LWTodoExample >> initialize [ 
  super initialize.
  items := OrderedCollection new.
]

{ #category : #accessing }
LWTodoExample >> item: aTodoItem [
 items add: aTodoItem.
 self changed.
]

{ #category : #'as yet unclassified' }
LWTodoExample >> itemClass: item [ 
 ^ item complete ifTrue: [ 'complete' ] ifFalse: [ 'incomplete' ]
]

{ #category : #rendering }
LWTodoExample >> renderOn: h [
	<lwHTML: '<div class="todos">
    <ul>
        <li lw:repeat="item items" class="todo {{self itemClass: item}}">
            <input type="checkbox" checked="{{item complete}}"> {{item label}}
        </li>
    </ul>
    todos here</div>'>
	h div: { 'class' -> ('todos').  } with: [ h renderContent: ('
    ').
h ul: {  } with: [ h renderContent: ('
        ').
(items) doWithIndex: [ :item :__lw_index | 
h li: { 'class' -> (String streamContents: [ :__lw_attr | __lw_attr << ('todo '). __lw_attr << (self itemClass: item). ]).  } with: [ h renderContent: ('
            ').
h input: { 'checked' -> (item complete). 'type' -> ('checkbox').  }.
h renderContent: (' ').
h renderContent: (item label).
h renderContent: ('
        ').
].
].
h renderContent: ('
    ').
].
h renderContent: ('
    todos here').
].

]
