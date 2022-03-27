"Start server on 8080 and map example page"
(ZnServer startDefaultOn: 8080) delegate
  map: '__liveweb' to: LWPageConnection;
  map: #examples to: LWExamplePage;
  map: #quit to: [ :_ | Smalltalk quitPrimitive ].

LWLogEvent logToStdout.

"Suspend UI process, not needed on headless"
(Process allSubInstances reject: #isTerminated)
  detect: [ :process | process name includesSubstring: 'UI Process' ]
  ifFound: [ :process | process suspend ].
Processor activeProcess suspend.