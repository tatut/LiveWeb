#!/bin/sh

cd $(dirname "$0")
clojure -X:test 2>&1 > /tmp/test.log
mv /tmp/test.log /tmp/test.done
