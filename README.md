# dotfiles

## 基本方針
- メンテコストがかかるのでスクリプトによる自動化は最低限に留める
- 同様の理由で Mac OS 以外での環境構築は考えないものとする
- テキストベースで管理できないGUIアプリの設定等に関しては環境構築のたびにメモを更新していく


## セットアップ手順
1. `xcode-select --install` (Gitコマンドを使えるようにする)
2. `curl -L raw.github.com/oskamathis/dotfiles/master/setup.sh | bash`


## セットアップ内容
1. dotfilesリポジトリをホームディレクトリ直下にダウンロード
2. 各種設定ファイルのシンボリックリンクをホームディレクトリ直下に作成
3. Homebrewをインストール
4. `brew bundle` でパッケージを一括インストール
5. tmux-powerlineを導入
6. ログインシェルを変更
7. sudoコマンドの認証にTouchIDを使えるようにする


## 手動設定項目
### Git
HomebrewでインストールしたGitのdiff-highlightを使えるようにする

`sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight`

### anyenv
`anyenv install --init`

### vim-plug
`vim -c PlugInstall -c q -c q`

### Mackup
Dropboxアプリを設定してからリストアを実行する

`mackup restore`
