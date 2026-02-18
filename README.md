# dotfiles

macOS 環境のセットアップと設定ファイル管理。[chezmoi](https://www.chezmoi.io/) を使用。

## 前提条件

- macOS
- Homebrew

## セットアップ

### 新しいマシンの場合

```bash
# Homebrew がなければインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# chezmoi をインストールして初期化
brew install chezmoi
chezmoi init --apply s-osa
```

### 既存マシンの更新

```bash
chezmoi update
```

## 構成

```
.
├── .chezmoi.toml.tmpl  # chezmoi 設定テンプレート
└── ...                 # 管理対象の設定ファイル
```

## 基本操作

```bash
chezmoi add ~/.config/xxx    # ファイルを管理対象に追加
chezmoi edit ~/.config/xxx   # 編集
chezmoi diff                 # 差分確認
chezmoi apply                # 適用
```
