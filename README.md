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

一部のファイルは chezmoi で直接管理せず、`.common` ファイルに共通設定を切り出したうえで、エントリーポイントから読み込む構成にしている。

この構成が必要になる理由は2つある。1つは**マシンごとに固有の設定を足したい**ケース（職場・個人など環境差異）。もう1つは**外部ツールが初期化コードをデフォルトパスのファイルに自動追記してくる**ケース（Rancher Desktop や mise 等）。どちらも、chezmoi がファイル全体を管理下に置いてしまうと対応が難しい。

そのため、共通設定は `.common` ファイルとして chezmoi で管理し、外部ツールが書き込んでくるデフォルトパスのファイルは `create_once_` で初回のみ生成して以後は chezmoi の同期対象から外している。

逆に、マシン差分も外部ツールの追記も生じないファイルは chezmoi で直接管理する。

### `.common` ファイル（chezmoi 管理）

共通設定の実体。chezmoi によって常に同期される。

| ファイル | 用途 |
|----------|------|
| `~/.zshrc.common` | zsh 共通設定 |
| `~/.zprofile.common` | zprofile 共通設定 |
| `~/.gitconfig.common` | Git 共通設定 |

### エントリーポイント（`create_once_`）

初回のみ作成され、以後 chezmoi は触らない。`.common` を読み込みつつ、マシン固有設定の追記や外部ツールによる自動追記を受け入れる。

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
