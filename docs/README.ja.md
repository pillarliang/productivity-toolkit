> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Python コードスタイル プラグイン

🌍 **言語**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

すべての Python コード生成において、プロフェッショナルな Python スタイルガイドラインを適用する Claude Code プラグインです。

## 機能

- **自動アクティベーション**：Claude がコードを生成またはレビューする際に、Python スタイルガイドラインを自動的に適用
- **コードレビューサポート**：既存の Python コードを詳細なフィードバックとスコアリングでレビュー
- **包括的なカバレッジ**：業界標準のベストプラクティスを含む
  - 命名規則（モジュール、クラス、関数、変数、定数）
  - Args、Returns、Raises、Yields セクションを含む docstring フォーマット
  - インポートルールと順序
  - フォーマット標準（インデント、行の長さ、空白）
  - 言語ルール（例外、型ヒント、内包表記）
- **詳細なリファレンス**：エッジケースのサポートドキュメント

## インストール

### 方法 1：Marketplace 経由（推奨）

Claude Code で実行：

```bash
# ステップ 1：marketplace を追加
/plugin marketplace add pillarliang/python-code-style

# ステップ 2：プラグインをインストール
/plugin install python-code-style
```

### 方法 2：settings.json 経由

`~/.claude/settings.json` に追加：

```json
{
  "extraKnownMarketplaces": {
    "python-code-style": {
      "source": {
        "source": "github",
        "repo": "pillarliang/python-code-style"
      }
    }
  },
  "enabledPlugins": {
    "python-code-style@python-code-style": true
  }
}
```

### 方法 3：手動インストール

```bash
# リポジトリをクローン
git clone https://github.com/pillarliang/python-code-style.git

# Claude プラグインディレクトリにコピー
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### インストールの確認

Claude Code で `/plugin` または `/plugin list` を実行して、インストールを確認してください。

### プラグインの更新

**手動更新：**

1. marketplace のプラグインリストを更新し、再インストール：
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. またはインタラクティブ UI から：`/plugin` を実行し、**Marketplaces** タブに切り替え、marketplace を選択して **Update** を選択。

**自動更新：**

Claude Code は起動時に marketplace とインストール済みプラグインの自動更新をサポートしています：

1. `/plugin` を実行してプラグインマネージャーを開く
2. **Marketplaces** タブを選択
3. 対象の marketplace を選択
4. **Enable auto-update** を選択

> **注意：** 公式 Anthropic marketplace はデフォルトで自動更新が有効になっています。サードパーティおよびローカル開発の marketplace はデフォルトで無効になっています。

## 使用方法

インストール後、以下の操作を Claude に依頼すると、プラグインが自動的にアクティベートされます：

- Python コードを書く
- Python スクリプトやモジュールを作成する
- Python コードをリファクタリングする
- Python 関数やクラスを生成する
- **既存の Python コードをレビューする**

### プロンプト例

**コード生成：**
```
"JSON ファイルを解析する Python 関数を書いて"

"データベース接続用の Python クラスを作成して"

"この Python コードをよりクリーンにリファクタリングして"
```

**コードレビュー：**
```
"この Python ファイルをレビューして：/path/to/file.py"

"この Python コードのスタイル問題をチェックして"
```

Claude は以下を含む Python スタイルガイドルールを自動的に適用します：

- 適切な命名規則（関数は `snake_case`、クラスは `CapWords`）
- Args、Returns、Raises セクションを含む docstring
- 正しいインポート順序（標準ライブラリ → サードパーティ → ローカル）
- 4 スペースインデントと 80 文字の行制限
- 関数シグネチャの型ヒント

### コードレビュー出力例

コードレビュー時、Claude は構造化されたフィードバックを提供します：

```markdown
## コードレビュー概要

### ✅ 良い点
- snake_case を使用した明確な関数命名
- 型ヒントの適切な使用

### ⚠️ 発見された問題

#### 問題 1：ドキュメント - docstring が不足
- **場所**：5 行目
- **問題**：関数 `process_data` に docstring がありません
- **提案**：Args/Returns/Raises セクションを含む docstring を追加してください

#### 問題 2：スタイル - ミュータブルなデフォルト引数
- **場所**：10 行目
- **問題**：`def func(items=[])` がミュータブルなデフォルト値を使用しています
- **提案**：`items=None` を使用し、関数内で初期化してください

### 📊 総合評価
- スタイル準拠：7/10
- ドキュメント：5/10
- コード品質：8/10
```

## 互換性

- **Claude Code**：v1.0.0+
- **Cowork モード**：完全サポート
- **Python バージョン**：Python 3.8+ に適用

## スタイルガイドのソース

このプラグインは、以下を含む広く採用されている Python スタイル規約に基づいています：

- [PEP 8 – Python コードスタイルガイド](https://peps.python.org/pep-0008/)
- [PEP 257 – Docstring 規約](https://peps.python.org/pep-0257/)
- [PEP 484 – 型ヒント](https://peps.python.org/pep-0484/)
- [Google Python スタイルガイド](https://google.github.io/styleguide/pyguide.html)

## ライセンス

このプラグインは [MIT ライセンス](https://opensource.org/licenses/MIT) の下でライセンスされています。
