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
6. HomebrewでインストールしたGitのdiff-highlightを使えるようにする
7. ログインシェルを変更
8. sudoコマンドの認証にTouch IDを使えるようにする


## 手動設定項目
### anyenv
初期化

```sh
anyenv install --init
```

プラグイン
```sh
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
git clone https://github.com/znz/anyenv-git.git $(anyenv root)/plugins/anyenv-git
git clone https://github.com/rugamaga/anyenv-tfenv-init.git $(anyenv root)/plugins/anyenv-tfenv-init
```

**envをインストール
```sh
anyenv install jenv
anyenv install rbenv
anyenv install pyenv
anyenv install tfenv
anyenv install nodenv
```

### vim-plug
```sh
vim -c PlugInstall -c q -c q
```

### Mackup
Dropboxアプリを設定してからリストアを実行する

```sh
mackup restore
```

### VSCode
コマンドパレットで `Shell Command: Install 'code' command in PATH` を実行

### pipx
pipxは一括でインストールする方法が無いので手動でインストールする

```sh
pipx install iredis
pipx install datadog
```

