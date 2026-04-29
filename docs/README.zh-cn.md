# 生产力工具集 (Productivity Toolkit)

🌍 **语言**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

一个 Claude Code 的多插件 marketplace,把若干"生产力插件"集中分发。一个仓库,多个插件,按需安装。

## 仓库内容

| 插件 | 作用 | 安装命令 |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | 在 Claude 生成或审查 Python 代码时,强制执行专业风格规范。涵盖命名、文档字符串、导入排序、PEP 8 / Google styleguide 规则。 | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | 把任意文本自动转换为单页 HTML 图表 + 独立 SVG。可从 17 种图(架构、流程、时序、ER、金字塔、环形…)中按内容自动选型。Kami 视觉风格。 | `/plugin install text-to-diagrams@productivity-toolkit` |

每个插件自包含——独立的 `plugin.json`、独立的 `SKILL.md`、独立的引用资源。Marketplace 只是把它们登记在册。

## 安装

### 1. 添加 marketplace(只需一次)

在 Claude Code 中执行:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. 选装你需要的插件

```bash
# 只装 Python 风格
/plugin install python-code-style@productivity-toolkit

# 只装图表生成
/plugin install text-to-diagrams@productivity-toolkit

# 全装
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### 备选:通过 settings.json 声明

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

### 备选:通过 `npx skills` 作为独立 skill 安装

如果只想要 skill 本身(`SKILL.md` 及其引用文件),不需要 Claude Code 插件包装——比如要分享给 Cursor 等其他 agent——可以用 [skills](https://skills.sh/) CLI:

```bash
# 全局安装两个 skill
npx skills add pillarliang/productivity-toolkit -g

# 只装其中一个
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

去掉 `-g` 则装到当前项目。用 `npx skills ls -g` 验证。

### 备选:手动安装

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### 验证

在 Claude Code 中运行 `/plugin` 或 `/plugin list`,确认插件已出现在已安装列表中。

## 更新

**手动更新:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

或交互式: `/plugin` → **Marketplaces** 标签页 → 选中此 marketplace → **Update**。

**自动更新:**

1. `/plugin` 打开插件管理器
2. **Marketplaces** 标签页
3. 选中目标 marketplace
4. **Enable auto-update**

> 第三方 marketplace 默认未开启自动更新,开启后 Claude Code 启动时会自动刷新。

## 卸载

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# 或者整个 marketplace 一并移除(会卸载该 marketplace 下所有插件)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## 仓库布局

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # 列出所有 plugin
├── plugins/
│   ├── python-code-style/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/python-code-style/
│   │       ├── SKILL.md
│   │       └── references/           # docstrings、命名、语言、风格规则
│   └── text-to-diagrams/
│       ├── .claude-plugin/plugin.json
│       └── skills/text-to-diagrams/
│           ├── SKILL.md
│           ├── README.md             # skill 自身文档
│           ├── templates/            # 17 种图模板 (HTML)
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # 可选 SVG→PNG 转换器
│           └── examples/             # 输入与渲染样例
├── docs/                             # 多语言 README
├── LICENSE
└── README.md
```

> **为什么这样布局?** 每个 `plugins/<名字>/` 都是一个完整的插件(自带 `plugin.json` 和 `skills/`),顶层 `marketplace.json` 只是用 `source` 字段把它们登记起来。新增第三个插件只需:在 `plugins/` 下新建目录,再往 `marketplace.json` 的 `plugins[]` 追加一项即可——插件之间零耦合。

## 在本 marketplace 中新增插件

1. 创建 `plugins/<你的插件>/.claude-plugin/plugin.json`
2. 添加 `plugins/<你的插件>/skills/<你的 skill>/SKILL.md`(frontmatter 必须有 `name` 和 `description`)
3. 放入该 skill 需要的辅助文件(references/、templates/ 等)
4. 在 `.claude-plugin/marketplace.json` 的 `plugins[]` 中追加一项,`source` 指向 `./plugins/<你的插件>`
5. 把顶层 `marketplace.json` 的 `version` 字段递增

完成,无需写胶水代码,也无注册步骤。

## 兼容性

- **Claude Code**: v1.0.0+
- **Cowork 模式**: 完全支持
- 各插件的具体兼容性详见对应目录

## 许可证

[MIT](../LICENSE)。

## 贡献指南

1. Fork 本仓库
2. 新建 feature 分支 (`git checkout -b feature/<名字>`)
3. 在 `plugins/<名字>/` 中改进现有插件,或按上文"在本 marketplace 中新增插件"添加新插件
4. 提交 Pull Request

## 更新日志

### v2.0.0

- **仓库重构**:从 `python-code-style` 更名为 `productivity-toolkit`,由单插件仓库升级为多插件 marketplace
- **新增插件**: `text-to-diagrams` —— 17 种图表自动生成器(架构、流程、时序、ER、金字塔、环形…),输出单 HTML 页面 + 独立 SVG
- `python-code-style` 迁移到 `plugins/python-code-style/`,功能不变,但安装命令改为带 namespace 的 `python-code-style@productivity-toolkit`

### v1.1.0 (python-code-style)

- 新增代码审查支持,提供详细反馈和评分
- 新增多语言 README(10 种语言)
- 改进 skill 触发条件

### v1.0.0 (python-code-style)

- 初始版本
