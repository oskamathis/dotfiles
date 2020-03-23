#!/bin/bash

set -u

DOTPATH=$(cd $(dirname $0); pwd)

for f in .??*; do
    [ "$f" = '.git' ]  && continue
    [ "$f" = '.gitignore' ] && continue
    [ "$f" = '.DS_Store' ] && continue

    ln -nfFsv $DOTPATH/$f ~/$f
done
