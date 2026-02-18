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
├── .chezmoi.toml.tmpl         # chezmoi 設定テンプレート
├── dot_*                      # 管理対象の設定ファイル（chezmoi が常に同期）
├── create_once_dot_*          # 初回のみ生成されるエントリーポイント
└── run_onchange_*             # ファイル変更時に実行されるスクリプト
```

## 設定ファイルの方針

### `.common` ファイル（chezmoi 管理）

実際の設定の実体。chezmoi によって常に同期される。

| ファイル | 用途 |
|----------|------|
| `~/.zshrc.common` | zsh 共通設定 |
| `~/.zprofile.common` | zprofile 共通設定 |
| `~/.gitconfig.common` | Git 共通設定 |

### エントリーポイント（`create_once_`）

初回のみ作成され、以後 chezmoi は触らない。外部ツール（Rancher Desktop、mise 等）が自由に追記できる。

| ファイル | 用途 |
|----------|------|
| `~/.zshrc` | `source ~/.zshrc.common` + マシン固有設定・外部ツールの追記 |
| `~/.zprofile` | `source ~/.zprofile.common` + マシン固有設定・外部ツールの追記 |
| `~/.gitconfig` | `[include] ~/.gitconfig.common` + マシン固有設定・外部ツールの追記 |

### 設定を追加するとき

- **複数マシンで共通の設定** → `.common` ファイルに追加（chezmoi で管理）
- **このマシン固有の設定** → エントリーポイント（`~/.zshrc` 等）に直接追記
- **外部ツールによる自動追記** → エントリーポイントに任せる

## 基本操作

```bash
chezmoi add ~/.config/xxx    # ファイルを管理対象に追加
chezmoi edit ~/.config/xxx   # 編集
chezmoi diff                 # 差分確認
chezmoi apply                # 適用
```
