# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    junegunn/fzf-bin \
    junegunn/fzf \
    zsh-users/zsh-syntax-highlighting \
    momo-lab/zsh-abbrev-alias \

zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# 履歴の設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{cyan}[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{magenta}[%b|%a]%f'

__vcs_info() { vcs_info }
precmd_functions+=( __vcs_info )

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit -C
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _list
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間で履歴を共有する
setopt share_history

# 同じコマンドを履歴に残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行は履歴に残さない
setopt hist_ignore_space

# 履歴に保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 履歴を検索するとき重複は飛ばす
setopt hist_find_no_dups

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# エイリアス
abbrev-alias --init
abbrev-alias relog='exec $SHELL -l' || alias relog='exec $SHELL -l'

abbrev-alias b='brew'
abbrev-alias bl='brew list'
abbrev-alias bu='brew upgrade'
abbrev-alias bc='brew cleanup'
abbrev-alias buc='brew upgrade && brew cleanup'

abbrev-alias lsd='lsd --group-dirs first -1F'
abbrev-alias la='lsd -1A'
abbrev-alias ll='lsd -l'
abbrev-alias lla='lsd -lA'
abbrev-alias lf='lsd -A | fzf'
abbrev-alias llf='lsd -Al | fzf'

abbrev-alias ls='ls -GF'
abbrev-alias rm='rm -i'
abbrev-alias cp='cp -i'
abbrev-alias mv='mv -i'
abbrev-alias mkdir='mkdir -p'

abbrev-alias gs='git status'
abbrev-alias gf='git fetch'
abbrev-alias gsu='git stash -u'
abbrev-alias gsa='git stash apply'
abbrev-alias gsp='git stash pop'
abbrev-alias gsc='git stash clear'
abbrev-alias gc='git checkout'
abbrev-alias gcb='git checkout -b'
abbrev-alias gcl='git-checkout-local'
abbrev-alias gcr='git-checkout-remote'
abbrev-alias gps='git push'
abbrev-alias -e gpsu='git push -u origin $(git_current_branch_name)'
abbrev-alias gpl='git pull'
abbrev-alias gplr='git pull --rebase origin develop'
abbrev-alias gr='git rebase'
abbrev-alias gra='git rebase --abort'
abbrev-alias grc='git rebase --continue'
abbrev-alias gb='git branch'
abbrev-alias -e gbm='git branch -m $(git_current_branch_name)'
abbrev-alias gm='git merge'
abbrev-alias gmn='git merge --no-ff --no-commit'

abbrev-alias gl='ghq-look'

abbrev-alias dc='docker-compose'
abbrev-alias dce='docker-compose exec'

abbrev-alias vrc='vim ~/.zshrc'
abbrev-alias vh='vim ~/.zsh_history'

abbrev-alias crc='code ~/.zshrc'
abbrev-alias ch='code ~/.zsh_history'

abbrev-alias t='tmux'
abbrev-alias tls='tmux ls'
abbrev-alias tlsk='tmux lsk | fzf'
abbrev-alias ts='tmux new -s'
abbrev-alias tr='tmux start && tmux run ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh'
abbrev-alias ta='tmux a'
abbrev-alias tas='tmux a -t'
abbrev-alias tk='tmux kill-session -t'
abbrev-alias tks='tmux kill-server'
abbrev-alias zt='time ( zsh -i -c exit )'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
abbrev-alias -g L='| less'
abbrev-alias -g G='| grep'
abbrev-alias -g F='| fzf'
abbrev-alias -g P='| pbcopy'
abbrev-alias -g -e B='$(git_current_branch_name)'

########################################
# 自作関数
vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`
function vl() {
    /usr/local/share/vim/vim${vim_version}/macros/less.sh $@
}

function zz() {
    local dir=$(fasd -Rdl $@ \
                | fzf --preview "lsd -F --group-dirs first --color always {}" \
                      --exit-0 --no-unicode --preview-window=right:30%)
    [ $dir ] && cd $dir
}

function v() {
    local file=$(fasd -Rfl $@ \
                 | fzf --preview "(highlight -O ansi -l {} || less {}) 2> /dev/null | head -100" \
                       --exit-0 --height 100% --preview-window=down:50%)
    [ $file ] && vim $file
}

function c() {
    local target=$(fasd -Rl $@ | fzf --exit-0)
    [ $target ] && code $target
}

function ghq-look() {
    local src=$(ghq list \
                | fzf --preview "lsd -F --group-dirs first --color always $(ghq root)/{}" \
                      --exit-0 --preview-window=right:30%)
    if [ -n "$src" ]; then
        BUFFER="cd $(ghq root)/$src"
        zle accept-line
    fi
    zle -R -c
}
zle -N ghq-look
bindkey '^]' ghq-look

function git-checkout-local() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git-checkout-remote() {
    git fetch
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function git_current_branch_name() {
    git symbolic-ref --short HEAD
}

########################################
# 実行に失敗したコマンドを履歴に残さない
__update_history() {
  local last_status="$?"

  local HISTFILE=~/.zsh_history
  fc -W
  if [[ ${last_status} -ne 0 ]]; then
    ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
  fi
}
precmd_functions+=(__update_history)

########################################
# cd後に自動でlsd実行
function chpwd() { lsd }

########################################
# zcompile
[[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc

########################################
# LESSOPEN でシンタックスハイライト
# `brew install source-highlight lesspipe`
if which lesspipe.sh > /dev/null; then
    export LESS_ADVANCED_PREPROCESSOR=1
    if which source-highlight > /dev/null; then
        export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
    else
        export LESSOPEN='| /usr/local/bin/lesspipe.sh %s'
    fi
fi

########################################
# manページをハイライト
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

########################################
# 初期化
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(anyenv init -)"
eval "$(direnv hook zsh)"
eval "$(fasd --init auto)" && unalias zz

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=vim
export FZF_DEFAULT_OPTS="--ansi --exit-0 --reverse --height 100% --border"
export LESS='-g -i -M -R -S -W -z-4 -x4'
export PAGER=less
export CLICOLOR=1

########################################
# パス
export PATH="/usr/local/opt/git/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# if (which zprof > /dev/null) ;then
#     zprof
# fi
