#!/bin/sh

# https://github.com/microsoft/vscode-remote-release/issues/2763#issuecomment-682276412
export "`tmux showenv PATH`"
