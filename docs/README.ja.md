# Productivity Toolkit

🌍 **言語**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

生産性プラグインをまとめた Claude Code マーケットプレイス。1 つのリポジトリに複数のプラグイン — 必要なものだけインストールできます。

## 内容

| プラグイン | 役割 | インストール |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | コード生成時にプロフェッショナルな Python スタイルガイドを強制し、構造化されたコードレビューを実現。命名規則、docstring 形式、import 順序、PEP 8 / Google styleguide ルール。 | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | 17 種類の図(アーキテクチャ、フローチャート、シーケンス、ER、ピラミッド、ドーナツ…)から自動選択し、生のテキストを 1 ページの HTML 図 + 個別 SVG に変換。Kami スタイル。 | `/plugin install text-to-diagrams@productivity-toolkit` |

各プラグインは自己完結 — 独自の `plugin.json`、`SKILL.md`、リファレンスとアセットを持ちます。マーケットプレイスはそれらを列挙するだけです。

## インストール

### 1. マーケットプレイスを追加

Claude Code で一度だけ実行:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. 必要なプラグインをインストール

```bash
# Python スタイルだけ
/plugin install python-code-style@productivity-toolkit

# 図表生成だけ
/plugin install text-to-diagrams@productivity-toolkit

# 両方
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### 代替方法: settings.json で宣言

```json
{
  "extraKnownMarketplaces": {
    "productivity-toolkit": {
      "source": {
        "source": "github",
        "repo": "pillarliang/productivity-toolkit"
      }
    }
  },
  "enabledPlugins": {
    "python-code-style@productivity-toolkit": true,
    "text-to-diagrams@productivity-toolkit": true
  }
}
```

### 代替方法: `npx skills` で独立 Skill としてインストール

Claude Code プラグインのラッパーなしで Skill 本体(`SKILL.md` とリファレンスファイル)だけ欲しい場合 — 例えば Cursor などの他のエージェントと共有したい場合 — [skills](https://skills.sh/) CLI を使います:

```bash
# 両方の Skill をグローバルにインストール
npx skills add pillarliang/productivity-toolkit -g

# 片方だけ
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

`-g` を省略すると現在のプロジェクトにインストールされます。`npx skills ls -g` で確認。

### 代替方法: 手動

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### 確認

Claude Code で `/plugin` または `/plugin list` を実行し、プラグインがインストール済みであることを確認します。

## 更新

**手動:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

または UI から: `/plugin` → **Marketplaces** タブ → 該当マーケットプレイスを選択 → **Update**。

**自動更新:**

1. `/plugin` を実行
2. **Marketplaces** タブ
3. 対象のマーケットプレイスを選択
4. **Enable auto-update**

> サードパーティのマーケットプレイスは自動更新がデフォルトでオフです。一度有効にすれば Claude Code 起動時に更新されます。

## アンインストール

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# またはマーケットプレイス全体を削除(配下の全プラグインがアンインストールされます)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## リポジトリ構成

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # 両プラグインを列挙
├── plugins/
│   ├── python-code-style/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/python-code-style/
│   │       ├── SKILL.md
│   │       └── references/           # docstrings, naming, language, style rules
│   └── text-to-diagrams/
│       ├── .claude-plugin/plugin.json
│       └── skills/text-to-diagrams/
│           ├── SKILL.md
│           ├── README.md             # Skill 固有のドキュメント
│           ├── templates/            # 17 種類の図の HTML テンプレート
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # オプションの SVG→PNG コンバーター
│           └── examples/             # サンプル入力 + レンダリング結果
├── docs/                             # 多言語 README
├── LICENSE
└── README.md                         # このファイル
```

> **なぜこの構成?** 各 `plugins/<名前>/` フォルダは完全に独立したプラグイン(独自の `plugin.json` と `skills/`)。トップレベルの `marketplace.json` はそれらを `source` パスで列挙するだけ。3 番目のプラグインを追加する = `plugins/` 配下に新フォルダを置き、`marketplace.json` に 1 エントリ追加するだけ。プラグイン間の結合は無し。

## このマーケットプレイスに新しいプラグインを追加する

1. `plugins/<your-plugin>/.claude-plugin/plugin.json` を作成
2. `plugins/<your-plugin>/skills/<your-skill>/SKILL.md` を追加(frontmatter に `name` と `description` 必須)
3. Skill が必要とするサポートファイル(references/、templates/ 等)を追加
4. `.claude-plugin/marketplace.json` の `plugins[]` に新エントリを追加し、`source: "./plugins/<your-plugin>"` を指定
5. マーケットプレイスの `version` フィールドをインクリメント

以上。グルーコードも登録ステップも不要。

## 互換性

- **Claude Code**: v1.0.0+
- **Cowork モード**: 完全対応
- 各プラグインの互換性はそれぞれのフォルダに記載

## ライセンス

[MIT](../LICENSE)。

## コントリビュート

1. リポジトリを fork
2. feature ブランチを作成 (`git checkout -b feature/<name>`)
3. `plugins/<name>/` 配下の既存プラグインを改善するか、新しいプラグインを追加(上記「新しいプラグインを追加する」を参照)
4. PR を開く

## 変更履歴

### v2.0.0

- **リポジトリ再構成**: `python-code-style` から `productivity-toolkit` にリネーム;単一プラグインからマルチプラグインマーケットプレイスへ転換
- **新プラグイン**: `text-to-diagrams` — 17 種類の図ジェネレーター(アーキテクチャ、フロー、シーケンス、ER、ピラミッド、ドーナツ…)、HTML 1 ページ + 図ごとの SVG を出力
- `python-code-style` を `plugins/python-code-style/` に移行(機能変更なし;インストールコマンドは namespace 付き形式に更新)

### v1.1.0 (python-code-style)

- 詳細なフィードバックとスコアリングを伴うコードレビューサポートを追加
- 多言語 README サポート(10 言語)を追加
- Skill のトリガー条件を改善

### v1.0.0 (python-code-style)

- 初回リリース
