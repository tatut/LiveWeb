FROM ubuntu:21.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y gnupg curl unzip rlwrap

RUN mkdir /pharo
WORKDIR /pharo
RUN curl -L https://get.pharo.org | bash

# Install
RUN ./pharo --headless -- eval "Metacello new repository: 'github://tatut/LiveWeb/src'; baseline: 'LiveWeb'; load: #(examples) . Smalltalk snapshot: true andQuit: true"

# entrypoint (we need sleep to make rlwrap work, async terminal settings)
CMD sleep 1; rlwrap ./pharo --headless -- eval "ZnServer startDefaultOn: 8080. ZnServer default delegate map: '__liveweb' to: LWPageConnection; map: #counter to: [ :req | (LWExamplePage of: LWMultiCounter) value: req ]; map: #clock to: [:req | (LWExamplePage of: LWClockExample) value: req ]; map: #wordle to: [:req | (LWExamplePage of: LWWordle) value: req ]; map: #quit to: [ :_ | Smalltalk quitPrimitive ]."