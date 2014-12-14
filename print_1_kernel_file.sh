#!/bin/bash

find $1 -type f | shuf | head -n +1 | xargs cat
