# LiveWeb

![test workflow](https://github.com/tatut/LiveWeb/actions/workflows/test.yml/badge.svg)

LiveWeb is a server side rendered web application framework for Smalltalk.
It is based on Zinc HTTP server and WebSockets.

The components live on the server and can send updates to clients through the web socket.


## Quick start guide

### Installation

```smalltalk
 Metacello new
   repository: 'github://tatut/LiveWeb/src';
   baseline: 'LiveWeb';
   load.
```

### Creating a page and component.

The main endpoint is an instance of `LWPage` subclass. The page will create the head (optional) and
body (required) components for each page render. The page will register itself with a random UUID
so the client can connect to it.

Creating a simple counter component.
```smalltalk
LWPage subclass: #CounterPage.

CounterPage >> body: args [
  ^ CounterComponent new
]
```

The create the component.
```smalltalk
LWComponent subclass: #CounterComponent
  instanceVariableNames: 'counter'.

CounterComponent >> initialize [
  super initialize.
  counter := 0
]

CounterComponent >> renderOn: h [
  h div: { #id->'myBody' } with: [
    h button: { #onclick -> [ self counter: counter - 1] } with: '-';
      div: counter asString;
      button: { #onclick -> [ self counter: counter + 1] } with: '+'
  ]
]

CounterComponent >> counter: newValue [
  counter := newValue.
  self changed "this causes the component to rerender"
]
```

Then you need to register the page into the Zinc server delegate.
```smalltalk
ZnServer default delegate
  map: #counter
  to: [:req | CounterPage new value: req ].
```

See the `LiveWeb-Examples` package for more elaborate examples and
examples of using the styling package.