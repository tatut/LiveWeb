#!/bin/sh
docker build . -t liveweb/examples
docker tag liveweb/examples antitadex/liveweb-examples
docker push antitadex/liveweb-examples
