# dotfiles

## 基本方針
* メンテコストがかかるのでスクリプトによる自動化は最低限に留める
* 同様の理由で Mac OS 以外での環境構築は考えないものとする
* テキストベースで管理できないGUIアプリの設定等に関しては環境構築のたびにメモを更新していく

## セットアップ手順
1. `xcode-select --install` (Gitコマンドを使えるようにする)
2. `curl -L dot.oskamathis.dev | bash`


## セットアップ内容
1. dotfilesリポジトリをホームディレクトリ直下にダウンロード
2. 各種設定ファイルのシンボリックリンクをホームディレクトリ直下に作成
3. Homebrewをインストール
4. `brew bundle` でパッケージを一括インストール
5. tmux-powerlineを導入
6. HomebrewでインストールしたGitのdiff-highlightを使えるようにする
7. ログインシェルを変更
8. sudoコマンドの認証にTouch IDを使えるようにする
9. GnuPGのpinentryを変更する


## 手動設定項目
### asdf
```sh
asdf plugin add java
asdf plugin add alias https://github.com/andrewthauer/asdf-alias.git
# asdf install java openjdk-17.0.2
# asdf alias java 17.0.2 openjdk-17.0.2
asdf plugin add python
```

### vim-plug
```sh
vim -c PlugInstall -c q -c q
```

### Mackup
Dropboxアプリの設定を済ませてからリストアを実行する
```sh
mackup restore
```

### VSCode
コマンドパレットで `Shell Command: Install 'code' command in PATH` を実行

### pipx
pipxは一括でインストールする方法が無いので手動でインストールする
```sh
pipx install datadog
```
