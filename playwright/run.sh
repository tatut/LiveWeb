#!/bin/sh

cd $(dirname "$0")
clojure -X:test 2>&1 > test.log
mv test.log test.done
