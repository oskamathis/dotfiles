#!/bin/bash

set -u # 未定義の変数使用時に終了

DOTPATH=~/dotfiles
GITHUB_URL=https://github.com/OskaMathis/dotfiles.git

echo '> download dotfiles'
git clone --recursive "$GITHUB_URL" "$DOTPATH"
cd $DOTPATH || exit 1

echo '> create symbolic links'
sh $DOTPATH/deploy.sh

echo '> install Homebrew'
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo '> install packages'
brew bundle --global

echo '> install tmux-powerline'
git clone https://github.com/OskaMathis/tmux-powerline.git ~/.tmux/tmux-powerline

echo '> initialize anyenv'
anyenv install --init

echo '> install vim plugins'
vim -c PlugInstall -c q -c q

echo '> change login shell'
sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh

cat << END

**************************************************
DOTFILES SETUP FINISHED!
**************************************************

END
