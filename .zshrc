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
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting \
    zsh-users/zsh-history-substring-search \
    junegunn/fzf-bin \
    junegunn/fzf \
    momo-lab/zsh-abbrev-alias \
    b4b4r07/enhancd \

zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# 色を使用出来るようにする
autoload -Uz colors
colors

# emacs 風キーバインドにする
bindkey -e

# zsh-history-substring-search
if zinit loaded zsh-history-substring-search >/dev/null 2>&1; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

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
FPATH=/opt/homebrew/share/zsh/site-functions:$FPATH

autoload -U bashcompinit
bashcompinit

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

# 小文字大文字の区別なしで補完、対象が見つからなかったらアスタリスクを付けて補完
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

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

# ディレクトリ補完時に末尾にスラッシュを追加
setopt auto_param_slash

########################################
# エイリアス
type abbrev-alias > /dev/null 2>&1 && abbrev-alias --init && alias alias='abbrev-alias'
alias relog=' exec $SHELL -l'
\alias mkcd=' (){mkdir $1 && cd $1}'
alias rlh=' remove-last-history'

alias b='brew'
alias bl='brew list'
alias bs=' brew search'
alias bu='brew upgrade'
alias bc='brew cleanup'
alias buc='brew upgrade && brew cleanup'
alias bi='brew install'
alias bic='brew install --cask'

\alias exa=' exa -Fh --group-directories-first --git --icons --time-style=long-iso'
alias l1='exa -1'
alias la='exa -1a'
alias ll='exa -l'
alias lla='exa -la'
alias lf='exa -a | fzf'
alias llf='exa -la | fzf'

alias man='tldr'
#alias sed='gsed'
#alias xargs='gxargs'
#alias awk='gawk'
#alias sort='gsort'
#alias find='gfind'

\alias ls=' ls'
\alias rm='rm -i'
\alias cp='cp -i'
\alias mv='mv -i'
\alias mkdir='mkdir -p'
\alias man=' man'
\alias cd=' __enhancd::cd'
\alias less=' less'
\alias vi=' vi'
\alias vim=' vim'
\alias code=' code'
\alias open=' open'
\alias touch='touch'
\alias where=' where'
\alias which=' which'
alias zz='j'
\alias j=' j'
\alias v=' v'
\alias c=' c'
\alias ghq=' ghq'
\alias bat=' bat'
\alias rg=' rg'
\alias tldr=' tldr'
\alias kill=' kill'
\alias pbcopy='pbcopy && pbpaste'

alias gi=' git-init'
alias gf=' git fetch'
alias gstu=' git stash -u'
alias gsta=' git stash apply'
alias gstp=' git stash pop'
alias gstc=' git stash clear'
alias gt='git tag -a'
alias gtd='git tag -d'
alias gs=' git switch'
alias gsc=' git switch -c'
alias gsd=' git switch -d'
alias gr=' git restore'
alias grs=' git restore -s'
alias gsl=' git-switch-local'
alias gst=' git-switch-tag'
alias gsr=' git-switch-remote'

alias gb=' git branch'
alias -e gbm=' git branch -m $(git_current_branch_name)'
alias gb-d=' git branch -D'

alias gps=' git push'
alias -e gpsu=' git push -u origin $(git_current_branch_name)'
alias gps-f=' git push --force-with-lease'
alias gpl=' git pull'
alias gplr=' git pull --rebase origin develop'
alias -e gpl-f=' git reset --hard origin/$(git_current_branch_name)'

alias grb=' git rebase'
alias grba=' git rebase --abort'
alias grbc=' git rebase --continue'
alias grbs=' git rebase --skip'

alias gm=' git merge'
alias gmn=' git merge --no-ff --no-commit'
alias gmc=' git merge --continue'
alias gma=' git merge --abort'
alias gms=' git merge --skip'

alias guc=' git-user-company'
alias gup=' git-user-personal'

alias gl=' ghq-look'

alias dc='docker-compose'
alias dce='docker-compose exec'

alias vrc='vim ~/.zshrc'
alias vh='vim $HISTFILE'

alias crc='code ~/.zshrc'
alias ch='code $HISTFILE'

alias t='tmux'
alias tls='tmux ls'
alias tlsk='tmux lsk | fzf'
alias ts='tmux new -s'
alias ta='tmux a'
alias tas='tmux a -t'
alias tk='tmux kill-session -t'
alias tks='tmux kill-server'

alias tf='terraform'
alias tfi='terraform init'
alias tfg='terraform get'
alias tfa='terraform apply'
alias tfp='terraform plan'
alias tfr='terraform refresh'
alias tfpr='terraform plan -refresh=false'
alias tfd='terraform destroy'
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'
alias tfwf='terraform workspace list | fzf | xargs terraform workspace select'
alias tff='terraform fmt'
alias tfv='terraform version'
alias tfpv='terraform providers'

alias zt='time ( zsh -i -c exit )'
alias al='abbrev-alias'
alias alf='abbrev-alias | fzf'

# sudo の後のコマンドでエイリアスを有効にする
\alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| rg'
alias -g F='| fzf'
alias -g P='| pbcopy'
alias -g C='| cat'
alias -g B='| bat'
alias -g J='| jid'
alias -g JF='| gron | fzf | gron -u'
alias -g T='| tee'

########################################
# 自作関数
vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`
function vless() {
    /usr/local/share/vim/vim${vim_version}/macros/less.sh $@
}

function j() {
    local dir=$(fasd -Rdl $@ \
                | fzf --preview "exa -1F --group-directories-first --color=always {}" \
                      --exit-0 --no-unicode --preview-window=right:30%)
    [ $dir ] && cd $dir
}

function v() {
    local file=$(fasd -Rfl $@ \
                 | fzf --preview "(bat --number --color always {}) 2> /dev/null | head -100" \
                       --exit-0 --height 100% --preview-window=down:50%)
    [ $file ] && vim $file
}

function c() {
    local target=$(fasd -Rl $@ | fzf --exit-0)
    [ $target ] && code $target
}

function ghq-look() {
    local src=$(ghq list \
                | fzf --preview "exa -1F --group-directories-first --color=always $(ghq root)/{}" \
                      --exit-0 --preview-window=right:30%)
    if [ -n "$src" ]; then
        cd $(ghq root)/$src
    fi
}

function git-init() {
    root=$(ghq root)/github.com/OskaMathis
    mkdir $root/$1
    cd $root/$1
    git init
    git-user-personal
    echo "# $1\n" > README.md
    git add README.md
    git commit -m "first commit"
}

function git-switch-local() {
    local branches branch
    branches=$(git branch | tr -d " ") &&
    branch=$(echo "$branches" | fzf +m --preview "git log --oneline --color=always {}") &&
    git switch $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function git-switch-tag() {
    git pull --tags
    local tags tag
    tags=$(git tag) &&
    tag=$(echo "$tags" | fzf +m --preview "git log --oneline --color=always {}") &&
    git switch -d $(echo "$tag" | awk '{print $1}' | sed "s/.* //")
}

function git-switch-remote() {
    git fetch
    local branches branch
    branches=$(git branch --all | grep -v HEAD | tr -d " ") &&
    branch=$(echo "$branches" | fzf +m --preview "git log --oneline --color=always {}") &&
    git switch $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function git_current_branch_name() {
    git symbolic-ref --short HEAD
}

function remove-last-history() {
    tail -1 $HISTFILE
    LC_ALL=C sed -i '' -e '$d' $HISTFILE
}

########################################
# cd後に自動でlla実行
chpwd() {
    if [[ $(pwd) != $HOME ]]; then;
        lla
    fi
}

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
# パス
typeset -U path PATH
export PATH="/opt/homebrew/git/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="$HOME/.anyenv/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin" # pipx

########################################
# 初期化
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(anyenv init -)"
eval "$(direnv hook zsh)"
eval "$(register-python-argcomplete pipx)"
eval "$(fasd --init zsh-hook)"

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export EDITOR=vim
export LESS='-g -i -M -R -S -W -z-4 -x4'
export PAGER=less
export CLICOLOR=1
export FZF_DEFAULT_OPTS="--ansi --exit-0 --reverse --height 100% --border"
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git"
export FZF_FIND_FILE_COMMAND=$FZF_DEFAULT_COMMAND
export BAT_THEME="OneHalfDark"
export AWS_PAGER=
export TF_CLI_ARGS_refresh="-parallelism=30"
export TF_CLI_ARGS_plan="-parallelism=30"
export TF_CLI_ARGS_apply="-parallelism=30"
export TF_CLI_ARGS_destroy="-parallelism=30"

# if (which zprof > /dev/null) ;then
#     zprof
# fi
