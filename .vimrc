"vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

"シンタックスハイライト設定
syntax on
colorscheme onedark
"TrueColor
set termguicolors
"背景透過
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
"削除時にブラックホールレジスタに放り込む
vnoremap d "_d
nnoremap d "_d
vnoremap D "_D
nnoremap D "_D
vnoremap x "_x
nnoremap x "_x
vnoremap X "_X
nnoremap X "_X
vnoremap s "_s
nnoremap s "_s
vnoremap S "_S
nnoremap S "_S
nnoremap ci "_ci
"マウス操作を有効にする
set mouse=a
set ttymouse=sgr
"インサートモードから抜けると自動的にIMEをオフにする
set iminsert=2
"OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
"vimdiffの設定
set diffopt=internal,filler,algorithm:histogram,indent-heuristic
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
"自動整形時に長いテキストが自動折返しされないように設定
set formatoptions=q
set textwidth=0
au FileType gitcommit setlocal tw=0
"jjでインサートモードから抜ける
inoremap <silent> jj <ESC>
"=====================================================
"行番号を表示する
set number
"編集中ファイル名の表示
set title
"対応する括弧を表示する
set showmatch
"タブ、空白、改行を可視化
set list
"カーソル行の背景色を変える
set cursorline
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells
"ステータス行を常に表示
set laststatus=2
"カーソル位置を表示
set ruler

"=====================================================
"文字コードを指定
set fenc=utf-8
"カーソルを行末の一つ先まで移動可能にする
set virtualedit=onemore
"新しい行のインデントを現在の行と同じにする
set autoindent
"高度な自動インデントを行う
set smartindent
"タブ文字の代わりに空白文字を挿入する
set expandtab
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"タブ文字が対応する空白の数
set tabstop=4
"シフト移動幅
set shiftwidth=4
"不可視文字の指定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,],~
"BSで削除できるものを指定する(バックスペースでの行移動を可能にする)
" indent : 行頭の空白
" eol    : 改行
" start  : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

"=====================================================
"検索時に大文字/小文字を区別しない
set ignorecase
"検索時に大文字を含んでいたら大/小を区別
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索した文字を強調
set hlsearch
"インクリメンタルサーチを有効にする
set incsearch

"=====================================================
"保存されていないファイルがあるときは終了前に保存確認
set confirm
"保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
"外部でファイルが変更された場合は読み直す
set autoread
"ファイル保存時にバックアップファイルを作らない
set nobackup
"ファイル編集中にスワップファイルを作らない
set noswapfile
