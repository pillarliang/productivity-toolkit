> ⚠️ This translation is out of date — repo was restructured in v2.0.0. See [English README](../README.md) or [中文简体](README.zh-cn.md) for the current layout and install instructions.

# Python 코드 스타일 플러그인

🌍 **언어**: [English](../README.md) | [中文简体](README.zh-cn.md) | [繁體中文](README.zh-tw.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [Italiano](README.it.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Português](README.pt.md) | [Español](README.es.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue.svg)](https://code.claude.com/docs/en/plugins)

모든 Python 코드 생성에 전문적인 Python 스타일 가이드라인을 적용하는 Claude Code 플러그인입니다.

## 기능

- **자동 활성화**: Claude가 코드를 생성하거나 검토할 때 Python 스타일 가이드라인을 자동으로 적용
- **코드 리뷰 지원**: 상세한 피드백과 점수로 기존 Python 코드 검토
- **포괄적인 범위**: 업계 표준 모범 사례 포함
  - 명명 규칙 (모듈, 클래스, 함수, 변수, 상수)
  - Args, Returns, Raises, Yields 섹션이 포함된 docstring 형식
  - import 규칙 및 순서
  - 포맷팅 표준 (들여쓰기, 줄 길이, 공백)
  - 언어 규칙 (예외, 타입 힌트, 컴프리헨션)
- **상세한 참조**: 엣지 케이스를 위한 지원 문서

## 설치

### 방법 1: Marketplace를 통해 (권장)

Claude Code에서 실행:

```bash
# 단계 1: marketplace 추가
/plugin marketplace add pillarliang/python-code-style

# 단계 2: 플러그인 설치
/plugin install python-code-style
```

### 방법 2: settings.json을 통해

`~/.claude/settings.json`에 추가:

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

### 방법 3: 수동 설치

```bash
# 저장소 복제
git clone https://github.com/pillarliang/python-code-style.git

# Claude 플러그인 디렉토리에 복사
cp -r python-code-style ~/.claude/plugins/python-code-style
```

### 설치 확인

Claude Code에서 `/plugin` 또는 `/plugin list`를 실행하여 설치를 확인하세요.

### 플러그인 업데이트

**수동 업데이트:**

1. marketplace 플러그인 목록을 업데이트한 후 재설치:
   ```bash
   /plugin marketplace update pillarliang/python-code-style
   ```

2. 또는 대화형 UI를 통해: `/plugin`을 실행하고 **Marketplaces** 탭으로 전환한 다음 marketplace를 선택하고 **Update**를 선택합니다.

**자동 업데이트:**

Claude Code는 시작 시 marketplace 및 설치된 플러그인의 자동 업데이트를 지원합니다:

1. `/plugin`을 실행하여 플러그인 관리자 열기
2. **Marketplaces** 탭 선택
3. 대상 marketplace 선택
4. **Enable auto-update** 선택

> **참고:** 공식 Anthropic marketplace는 기본적으로 자동 업데이트가 활성화되어 있습니다. 타사 및 로컬 개발 marketplace는 기본적으로 비활성화되어 있습니다.

## 사용법

설치 후, Claude에게 다음을 요청하면 플러그인이 자동으로 활성화됩니다:

- Python 코드 작성
- Python 스크립트 또는 모듈 생성
- Python 코드 리팩토링
- Python 함수 또는 클래스 생성
- **기존 Python 코드 검토**

### 프롬프트 예시

**코드 생성:**
```
"JSON 파일을 파싱하는 Python 함수를 작성해줘"

"데이터베이스 연결을 위한 Python 클래스를 만들어줘"

"이 Python 코드를 더 깔끔하게 리팩토링해줘"
```

**코드 리뷰:**
```
"이 Python 파일을 검토해줘: /path/to/file.py"

"이 Python 코드의 스타일 문제를 확인해줘"
```

Claude는 다음을 포함한 Python 스타일 가이드 규칙을 자동으로 적용합니다:

- 적절한 명명 규칙 (함수는 `snake_case`, 클래스는 `CapWords`)
- Args, Returns, Raises 섹션이 포함된 docstring
- 올바른 import 순서 (표준 라이브러리 → 서드파티 → 로컬)
- 4칸 들여쓰기 및 80자 줄 제한
- 함수 시그니처의 타입 힌트

### 코드 리뷰 출력 예시

코드 검토 시, Claude는 구조화된 피드백을 제공합니다:

```markdown
## 코드 리뷰 요약

### ✅ 좋은 점
- snake_case를 사용한 명확한 함수 명명
- 타입 힌트의 적절한 사용

### ⚠️ 발견된 문제

#### 문제 1: 문서화 - docstring 누락
- **위치**: 5번째 줄
- **문제**: 함수 `process_data`에 docstring이 없습니다
- **제안**: Args/Returns/Raises 섹션이 포함된 docstring 추가

#### 문제 2: 스타일 - 가변 기본 인수
- **위치**: 10번째 줄
- **문제**: `def func(items=[])`가 가변 기본값을 사용합니다
- **제안**: `items=None`을 사용하고 함수 내부에서 초기화

### 📊 전체 평가
- 스타일 준수: 7/10
- 문서화: 5/10
- 코드 품질: 8/10
```

## 호환성

- **Claude Code**: v1.0.0+
- **Cowork 모드**: 완전 지원
- **Python 버전**: Python 3.8+ 에 적용

## 스타일 가이드 출처

이 플러그인은 다음을 포함한 널리 채택된 Python 스타일 규칙을 기반으로 합니다:

- [PEP 8 – Python 코드 스타일 가이드](https://peps.python.org/pep-0008/)
- [PEP 257 – Docstring 규칙](https://peps.python.org/pep-0257/)
- [PEP 484 – 타입 힌트](https://peps.python.org/pep-0484/)
- [Google Python 스타일 가이드](https://google.github.io/styleguide/pyguide.html)

## 라이선스

이 플러그인은 [MIT 라이선스](https://opensource.org/licenses/MIT) 하에 배포됩니다.
