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

# 依存パッケージをインストール
brew bundle --global
```

### 既存マシンの更新

```bash
chezmoi update
```

## 構成

```
.
├── .chezmoi.toml.tmpl  # chezmoi 設定テンプレート
├── dot_*               # 管理対象の設定ファイル
└── create_dot_*        # 初回のみ生成されるファイル
```

## マシン固有設定

以下のファイルは `create_` プレフィックスにより初回のみ生成され、chezmoi 管理外となります。マシン固有の設定はこれらに記述してください。

| ファイル | 用途 |
|----------|------|
| `~/.gitconfig.local` | Git のマシン固有設定（includeIf 等） |
| `~/.zshrc.local` | シェルのマシン固有設定（PATH, alias 等） |
| `~/.zprofile.local` | ログインシェルのマシン固有設定 |

## 基本操作

```bash
chezmoi add ~/.config/xxx    # ファイルを管理対象に追加
chezmoi edit ~/.config/xxx   # 編集
chezmoi diff                 # 差分確認
chezmoi apply                # 適用
```
