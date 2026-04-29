> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Python 程式碼風格外掛

🌍 **語言**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

一個 Claude Code 外掛，用於在生成 Python 程式碼時強制執行專業的程式碼風格規範。

## 功能特性

- **自動啟用**：Claude 在生成或審查程式碼時自動遵循 Python 風格指南
- **程式碼審查支援**：審查現有 Python 程式碼，提供詳細回饋和評分
- **全面覆蓋**：包含業界標準最佳實踐
  - 命名規範（模組、類別、函式、變數、常數）
  - 文件字串格式（Args、Returns、Raises、Yields 區段）
  - 匯入規則和排序
  - 格式化標準（縮排、行長度、空白）
  - 語言規則（例外、型別提示、推導式）
- **詳細參考**：邊緣情況的支援文件

## 安裝

### 方法 1：透過 Marketplace（推薦）

在 Claude Code 中執行：

```bash
# 步驟 1：新增 marketplace
/plugin marketplace add pillarliang/python-code-style

# 步驟 2：安裝外掛
/plugin install python-code-style
```

### 方法 2：透過 settings.json

新增到 `~/.claude/settings.json`：

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

### 方法 3：手動安裝

```bash
# 複製儲存庫
git clone https://github.com/pillarliang/python-code-style.git

# 複製到 Claude 外掛目錄
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### 驗證安裝

在 Claude Code 中執行 `/plugin` 或 `/plugin list` 確認外掛已安裝。

### 更新外掛

**手動更新：**

1. 更新 marketplace 的外掛列表，然後重新安裝：
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. 或透過互動式介面：執行 `/plugin`，切換到 **Marketplaces** 標籤頁，選擇對應的 marketplace，然後選擇 **Update**。

**自動更新（Auto-update）：**

Claude Code 支援在啟動時自動更新 marketplace 及其已安裝的外掛：

1. 執行 `/plugin` 開啟外掛管理器
2. 選擇 **Marketplaces** 標籤頁
3. 選中目標 marketplace
4. 選擇 **Enable auto-update**

> **注意：** 官方 Anthropic marketplace 預設已啟用自動更新，第三方和本地開發的 marketplace 預設是關閉的。

## 使用方法

安裝後，當您要求 Claude 執行以下操作時，外掛會自動啟用：

- 撰寫 Python 程式碼
- 建立 Python 指令碼或模組
- 重構 Python 程式碼
- 生成 Python 函式或類別
- **審查現有 Python 程式碼**

### 範例提示

**程式碼生成：**
```
"寫一個解析 JSON 檔案的 Python 函式"

"建立一個資料庫連線的 Python 類別"

"重構這段 Python 程式碼使其更簡潔"
```

**程式碼審查：**
```
"審查這個 Python 檔案：/path/to/file.py"

"檢查這段 Python 程式碼的風格問題"
```

Claude 將自動套用 Python 風格指南規則，包括：

- 正確的命名規範（函式用 `snake_case`，類別用 `CapWords`）
- 包含 Args、Returns、Raises 區段的文件字串
- 正確的匯入排序（標準函式庫 → 第三方函式庫 → 本地函式庫）
- 4 空格縮排和 80 字元行限制
- 函式簽章的型別提示

### 程式碼審查輸出範例

審查程式碼時，Claude 提供結構化回饋：

```markdown
## 程式碼審查摘要

### ✅ 優點
- 函式命名清晰，使用 snake_case
- 型別提示使用良好

### ⚠️ 發現的問題

#### 問題 1：文件 - 缺少文件字串
- **位置**：第 5 行
- **問題**：函式 `process_data` 缺少文件字串
- **建議**：新增包含 Args/Returns/Raises 區段的文件字串

#### 問題 2：風格 - 可變預設參數
- **位置**：第 10 行
- **問題**：`def func(items=[])` 使用了可變預設值
- **建議**：使用 `items=None` 並在函式內部初始化

### 📊 總體評估
- 風格合規性：7/10
- 文件完整性：5/10
- 程式碼品質：8/10
```

## 相容性

- **Claude Code**：v1.0.0+
- **Cowork 模式**：完全支援
- **Python 版本**：規則適用於 Python 3.8+

## 風格指南來源

本外掛基於廣泛採用的 Python 風格規範，包括：

- [PEP 8 – Python 程式碼風格指南](https://peps.python.org/pep-0008/)
- [PEP 257 – 文件字串規範](https://peps.python.org/pep-0257/)
- [PEP 484 – 型別提示](https://peps.python.org/pep-0484/)
- [Google Python 風格指南](https://google.github.io/styleguide/pyguide.html)

## 授權條款

本外掛基於 [MIT 授權條款](https://opensource.org/licenses/MIT) 授權。
