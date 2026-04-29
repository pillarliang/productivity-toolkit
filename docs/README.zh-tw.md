# 生產力工具集 (Productivity Toolkit)

🌍 **語言**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

一個 Claude Code 的多外掛 marketplace,把若干「生產力外掛」集中分發。一個儲存庫,多個外掛,按需安裝。

## 倉庫內容

| 外掛 | 功能 | 安裝指令 |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | 在 Claude 生成或審查 Python 程式碼時,強制執行專業風格規範。涵蓋命名、文件字串、匯入排序、PEP 8 / Google styleguide 規則。 | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | 把任意文字自動轉換為單頁 HTML 圖表 + 獨立 SVG。可從 17 種圖(架構、流程、時序、ER、金字塔、環形…)中按內容自動選型。Kami 視覺風格。 | `/plugin install text-to-diagrams@productivity-toolkit` |

每個外掛皆為獨立模組——擁有自己的 `plugin.json`、`SKILL.md` 與引用資源。Marketplace 只負責登記。

## 安裝

### 1. 加入 marketplace(只需一次)

在 Claude Code 中執行:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. 選裝你需要的外掛

```bash
# 只裝 Python 風格
/plugin install python-code-style@productivity-toolkit

# 只裝圖表生成
/plugin install text-to-diagrams@productivity-toolkit

# 全裝
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### 替代方案:在 settings.json 中宣告

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

### 替代方案:透過 `npx skills` 以獨立 skill 形式安裝

如果只需要 skill 本身(`SKILL.md` 及其引用檔案),不需要 Claude Code 外掛包裝——例如要分享給 Cursor 等其他 agent——可以使用 [skills](https://skills.sh/) CLI:

```bash
# 全域安裝兩個 skill
npx skills add pillarliang/productivity-toolkit -g

# 只安裝其中一個
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

省略 `-g` 則安裝至目前專案。可用 `npx skills ls -g` 驗證。

### 替代方案:手動安裝

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### 驗證

在 Claude Code 中執行 `/plugin` 或 `/plugin list`,確認外掛已出現在已安裝清單中。

## 更新

**手動更新:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

或透過互動介面: `/plugin` → **Marketplaces** 分頁 → 選取此 marketplace → **Update**。

**自動更新:**

1. 執行 `/plugin` 開啟外掛管理員
2. 切到 **Marketplaces** 分頁
3. 選取目標 marketplace
4. **Enable auto-update**

> 第三方 marketplace 預設未啟用自動更新,啟用後 Claude Code 啟動時會自動重新整理。

## 解除安裝

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# 或直接移除整個 marketplace(會解除安裝其下所有外掛)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## 倉庫結構

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # 列出所有 plugin
├── plugins/
│   ├── python-code-style/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/python-code-style/
│   │       ├── SKILL.md
│   │       └── references/           # docstrings、命名、語言、風格規則
│   └── text-to-diagrams/
│       ├── .claude-plugin/plugin.json
│       └── skills/text-to-diagrams/
│           ├── SKILL.md
│           ├── README.md             # skill 自身文件
│           ├── templates/            # 17 種圖表模板 (HTML)
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # 選用 SVG→PNG 轉換器
│           └── examples/             # 輸入與渲染範例
├── docs/                             # 多語言 README
├── LICENSE
└── README.md
```

> **為何採用此結構?** 每個 `plugins/<名稱>/` 都是一個完整的外掛(自帶 `plugin.json` 與 `skills/`),頂層 `marketplace.json` 只是用 `source` 欄位把它們登記起來。要新增第三個外掛只需:在 `plugins/` 下新建目錄,再往 `marketplace.json` 的 `plugins[]` 追加一項即可——外掛之間零耦合。

## 在本 marketplace 中新增外掛

1. 建立 `plugins/<你的外掛>/.claude-plugin/plugin.json`
2. 加入 `plugins/<你的外掛>/skills/<你的 skill>/SKILL.md`(frontmatter 必須含 `name` 與 `description`)
3. 放入該 skill 所需的輔助檔案(references/、templates/ 等)
4. 在 `.claude-plugin/marketplace.json` 的 `plugins[]` 中追加一項,`source` 指向 `./plugins/<你的外掛>`
5. 將頂層 `marketplace.json` 的 `version` 欄位遞增

完成,不需要任何膠合程式碼,也沒有註冊步驟。

## 相容性

- **Claude Code**: v1.0.0+
- **Cowork 模式**: 完全支援
- 各外掛的具體相容性詳見對應目錄

## 授權條款

[MIT](../LICENSE)。

## 貢獻指南

1. Fork 本儲存庫
2. 建立 feature 分支 (`git checkout -b feature/<名稱>`)
3. 在 `plugins/<名稱>/` 中改進現有外掛,或依上文「在本 marketplace 中新增外掛」加入新外掛
4. 送出 Pull Request

## 更新紀錄

### v2.0.0

- **倉庫重構**:從 `python-code-style` 更名為 `productivity-toolkit`,由單外掛倉庫升級為多外掛 marketplace
- **新增外掛**: `text-to-diagrams` —— 17 種圖表自動生成器(架構、流程、時序、ER、金字塔、環形…),輸出單 HTML 頁面 + 獨立 SVG
- `python-code-style` 移至 `plugins/python-code-style/`,功能不變,但安裝指令改為帶 namespace 的 `python-code-style@productivity-toolkit`

### v1.1.0 (python-code-style)

- 新增程式碼審查支援,提供詳細回饋與評分
- 新增多語言 README(10 種語言)
- 改善 skill 觸發條件

### v1.0.0 (python-code-style)

- 初始版本
