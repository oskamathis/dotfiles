#!/bin/bash

set -u # 未定義の変数使用時に終了

DOTPATH=~/dotfiles
GITHUB_URL=https://github.com/oskamathis/dotfiles.git

echo '> download dotfiles'
git clone --recursive "$GITHUB_URL" "$DOTPATH"
cd $DOTPATH || exit 1

echo '> create symbolic links'
/bin/bash $DOTPATH/deploy.sh

echo '> install Homebrew'
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo '> install packages'
brew bundle --global

echo '> install tmux-powerline'
git clone https://github.com/oskamathis/tmux-powerline.git ~/.tmux/tmux-powerline

echo '> setup diff-highlight'
sudo ln -s /opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight /opt/homebrew/bin/diff-highlight

echo '> change login shell'
sudo sh -c 'echo /opt/homebrew/bin/zsh >> /etc/shells' && chsh -s /opt/homebrew/bin/zsh

echo '> setup pam'
if ! grep -Eq '^auth\s.*\spam_tid\.so$' /etc/pam.d/sudo; then
    ( set -e; set -o pipefail
        # 最初の auth として pam_tid.so を追加
        pam_sudo=$(awk 'fixed||!/^auth /{print} !fixed&&/^auth/{print "auth       sufficient     pam_tid.so";print;fixed=1}' /etc/pam.d/sudo)
        sudo tee /etc/pam.d/sudo <<<"$pam_sudo"
    )
fi

if { ! grep -Eq '^auth\s.*\/opt/homebrew/lib/pam/pam_reattach\.so$' /etc/pam.d/sudo } && [ -f /opt/homebrew/lib/pam/pam_reattach.so ]; then
    ( set -e; set -o pipefail
        # pam_tid.so の手前に pam_reattach.so を追加
        pam_sudo=$(awk 'fixed||!/^auth .* pam_tid.so$/{print} !fixed&&/^auth/{print "auth       optional       /opt/homebrew/lib/pam/pam_reattach.so";print;fixed=1}' /etc/pam.d/sudo)
        sudo tee /etc/pam.d/sudo <<<"$pam_sudo"
    )
fi

cat << END

**************************************************
DOTFILES SETUP FINISHED!
**************************************************

END
