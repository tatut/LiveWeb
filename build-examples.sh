#!/bin/sh
docker build --platform linux/amd64 . -t liveweb/examples
docker tag liveweb/examples antitadex/liveweb-examples
docker push antitadex/liveweb-examples
