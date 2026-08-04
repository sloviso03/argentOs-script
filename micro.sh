#!/bin/bash

set -e

mkdir -p ~/.config/micro

cp -r "$(dirname "$0")/micro/"* ~/.config/micro/

micro -plugin install lsp || true
micro -plugin install filemanager || true
micro -plugin install fzf || true
micro -plugin install manipulator || true
