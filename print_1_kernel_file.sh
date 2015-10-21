#!/usr/bin/env bash

find $1 -type f -a -name '*.[ch]pp' | shuf | head -n +1 | xargs cat
