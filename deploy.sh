#!/bin/bash

set -u

DOTPATH=$(cd $(dirname $0); pwd)

while read -r f; do
    [ "$f" = '.git' ] && continue
    [ "$f" = '.gitignore' ] && continue
    [ "$f" = '.DS_Store' ] && continue
    [ "$f" = '.config' ] && continue

    ln -nfFsv $DOTPATH/$f ~/$f
done < <(find .* -maxdepth 0)

mkdir -p ~/.config
while read -r f; do
    ln -nfFsv $DOTPATH/$f ~/$f
done < <(find .config -mindepth 1 -maxdepth 1)
