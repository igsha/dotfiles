#!/usr/bin/env bash

LANGENV_NIX=langenv.nix

GREP_CMD="ack '^\s*(\w+)env\s*=' $LANGENV_NIX --output '\$1'"

eval $GREP_CMD | xargs -n1 -I {} nix-instantiate $LANGENV_NIX -A {}env --indirect --add-root $PWD/{}.drv
eval $GREP_CMD | xargs -n1 -I {} nix-shell $PWD/{}.drv --run exit
