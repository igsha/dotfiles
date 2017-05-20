#!/usr/bin/env bash

socat EXEC:echo UNIX-CONNECT:$RXVT_SOCKET
urxvtc
urxvtc -name nvim -title Neovim -e nvim
