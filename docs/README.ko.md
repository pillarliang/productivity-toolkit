# Productivity Toolkit

🌍 **언어**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Marketplace](https://img.shields.io/badge/Claude%20Code-Marketplace-blue.svg)](https://code.claude.com/docs/en/plugins)

생산성 플러그인을 모아둔 Claude Code 마켓플레이스. 하나의 저장소, 여러 플러그인 — 필요한 것만 설치하세요.

## 구성

| 플러그인 | 역할 | 설치 |
| --- | --- | --- |
| **[python-code-style](../plugins/python-code-style/)** | Python 코드 생성 시 전문적인 스타일 가이드를 강제하고, 구조화된 코드 리뷰를 지원합니다. 명명 규칙, docstring 형식, import 정렬, PEP 8 / Google styleguide 규칙. | `/plugin install python-code-style@productivity-toolkit` |
| **[text-to-diagrams](../plugins/text-to-diagrams/)** | 17가지 다이어그램(아키텍처, 플로우차트, 시퀀스, ER, 피라미드, 도넛…)에서 자동 선택하여 원본 텍스트를 단일 HTML 페이지의 다이어그램 + 독립 SVG로 변환합니다. Kami 스타일. | `/plugin install text-to-diagrams@productivity-toolkit` |

각 플러그인은 자체 완결적입니다 — 자체 `plugin.json`, 자체 `SKILL.md`, 자체 references와 assets를 가집니다. 마켓플레이스는 그것들을 나열할 뿐입니다.

## 설치

### 1. 마켓플레이스 추가

Claude Code에서 한 번만 실행:

```bash
/plugin marketplace add pillarliang/productivity-toolkit
```

### 2. 원하는 플러그인 설치

```bash
# Python 스타일만
/plugin install python-code-style@productivity-toolkit

# 다이어그램만
/plugin install text-to-diagrams@productivity-toolkit

# 둘 다
/plugin install python-code-style@productivity-toolkit
/plugin install text-to-diagrams@productivity-toolkit
```

### 대안: settings.json에 선언

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

### 대안: `npx skills`로 독립 Skill로 설치

Claude Code 플러그인 래퍼 없이 Skill 본체(`SKILL.md`와 references)만 원한다면 — 예를 들어 Cursor 같은 다른 에이전트와 공유하려면 — [skills](https://skills.sh/) CLI를 사용하세요:

```bash
# 두 Skill 모두 글로벌로 설치
npx skills add pillarliang/productivity-toolkit -g

# 하나만 설치
npx skills add pillarliang/productivity-toolkit -g --skill python-code-style
npx skills add pillarliang/productivity-toolkit -g --skill text-to-diagrams
```

`-g`를 생략하면 현재 프로젝트에 설치됩니다. `npx skills ls -g`로 확인하세요.

### 대안: 수동 설치

```bash
git clone https://github.com/pillarliang/productivity-toolkit.git
cp -r productivity-toolkit/plugins/python-code-style ~/.claude/plugins/
cp -r productivity-toolkit/plugins/text-to-diagrams ~/.claude/plugins/
```

### 검증

Claude Code에서 `/plugin` 또는 `/plugin list`를 실행하여 플러그인이 설치되었는지 확인합니다.

## 업데이트

**수동:**

```bash
/plugin marketplace update pillarliang/productivity-toolkit
```

또는 UI에서: `/plugin` → **Marketplaces** 탭 → 마켓플레이스 선택 → **Update**.

**자동 업데이트:**

1. `/plugin` 실행
2. **Marketplaces** 탭
3. 대상 마켓플레이스 선택
4. **Enable auto-update**

> 서드파티 마켓플레이스는 자동 업데이트가 기본 비활성화되어 있습니다. 한 번 활성화하면 Claude Code가 시작 시 새로 고칩니다.

## 제거

```bash
/plugin uninstall python-code-style@productivity-toolkit
/plugin uninstall text-to-diagrams@productivity-toolkit

# 또는 마켓플레이스 전체 제거(해당 마켓플레이스의 모든 플러그인 제거됨)
/plugin marketplace remove pillarliang/productivity-toolkit
```

## 저장소 구조

```text
productivity-toolkit/
├── .claude-plugin/
│   └── marketplace.json              # 두 플러그인을 나열
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
│           ├── README.md             # Skill 자체 문서
│           ├── templates/            # 17가지 다이어그램 HTML 템플릿
│           ├── references/           # style.md, diagrams.md, page-shell.html
│           ├── tools/svg-to-png.sh   # 선택적 SVG→PNG 변환기
│           └── examples/             # 샘플 입력 + 렌더링 결과
├── docs/                             # 다국어 README
├── LICENSE
└── README.md                         # 이 파일
```

> **왜 이 구조인가?** 각 `plugins/<name>/` 폴더는 그 자체로 완전한 플러그인입니다(자체 `plugin.json`과 `skills/` 보유). 최상위 `marketplace.json`은 단지 그것들을 `source` 경로로 나열할 뿐입니다. 세 번째 플러그인을 추가하려면 = `plugins/` 아래에 새 폴더를 두고 `marketplace.json`에 항목 하나 추가하면 끝. 플러그인 간 결합 없음.

## 이 마켓플레이스에 새 플러그인 추가하기

1. `plugins/<your-plugin>/.claude-plugin/plugin.json` 생성
2. `plugins/<your-plugin>/skills/<your-skill>/SKILL.md` 추가(frontmatter에 `name` + `description` 필수)
3. Skill에 필요한 보조 파일(references/, templates/ 등) 추가
4. `.claude-plugin/marketplace.json`의 `plugins[]`에 `source: "./plugins/<your-plugin>"`로 새 항목 추가
5. 마켓플레이스의 `version` 필드를 증가

끝. 글루 코드도 등록 단계도 없습니다.

## 호환성

- **Claude Code**: v1.0.0+
- **Cowork 모드**: 완전 지원
- 각 플러그인의 호환성은 자체 폴더에 문서화

## 라이선스

[MIT](../LICENSE).

## 기여

1. 저장소를 fork
2. feature 브랜치 생성 (`git checkout -b feature/<name>`)
3. `plugins/<name>/`의 기존 플러그인을 개선하거나 새 플러그인 추가(위의 "새 플러그인 추가하기" 참조)
4. PR을 엽니다

## 변경 이력

### v2.0.0

- **저장소 재구조화**: `python-code-style`에서 `productivity-toolkit`로 이름 변경; 단일 플러그인에서 멀티 플러그인 마켓플레이스로 전환
- **새 플러그인**: `text-to-diagrams` — 17가지 다이어그램 생성기(아키텍처, 플로우, 시퀀스, ER, 피라미드, 도넛…), HTML 한 페이지 + 도형별 SVG 생성
- `python-code-style`이 `plugins/python-code-style/`로 이전(기능 변화 없음; 설치 명령은 namespace 형식으로 업데이트)

### v1.1.0 (python-code-style)

- 상세한 피드백과 점수가 있는 코드 리뷰 지원 추가
- 다국어 README 지원(10개 언어) 추가
- Skill 트리거 조건 개선

### v1.0.0 (python-code-style)

- 초기 릴리스
