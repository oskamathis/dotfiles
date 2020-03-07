"新しい行のインデントを現在の行と同じにする
set autoindent

"vi互換を切る
set nocompatible

"タブの代わりに空白文字を挿入する
set expandtab

"変更中のファイルでも、保存しないで他のファイルを表示
set hidden

"インクリメンタルサーチを行う
set incsearch

"行番号を表示する
set number

"シフト移動幅
set shiftwidth=4

"対応する括弧を表示する
set showmatch

"検索時に大文字を含んでいたら大/小を区別
set smartcase

"高度な自動インデントを行う
set smartindent

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab

"ファイル内の <Tab> が対応する空白の数
set tabstop=4

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"検索をファイルの先頭へループしない
set nowrapscan

"yankした内容がクリップボードにも入るようにする
set clipboard+=unnamed

"BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

"シンタックスハイライト
let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
    :set term=xterm-256color
    :syntax on
endif
