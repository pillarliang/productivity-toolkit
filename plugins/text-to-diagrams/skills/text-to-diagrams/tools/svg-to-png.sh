#!/usr/bin/env bash
# svg-to-png.sh — convert text-to-diagrams SVG output to PNG.
#
# Usage:
#   bash tools/svg-to-png.sh <file.svg>          # single file
#   bash tools/svg-to-png.sh <directory>         # batch: every *.svg in the dir
#   bash tools/svg-to-png.sh <input> <output>    # explicit output path (single only)
#
# Options (env vars):
#   PNG_WIDTH=2000        # default 2000px wide; height auto from SVG aspect
#   PNG_BG=transparent    # default transparent; set to '#f5f4ed' to match parchment
#
# Picks the first available converter:
#   1. rsvg-convert  (brew install librsvg)              — fastest, sharpest
#   2. chromium / google-chrome / "Google Chrome"        — fallback, slower
#
# Exits non-zero with a clear message if no converter is found.

set -euo pipefail

PNG_WIDTH="${PNG_WIDTH:-2000}"
PNG_BG="${PNG_BG:-transparent}"

die() { printf 'svg-to-png: %s\n' "$*" >&2; exit 1; }

find_converter() {
  if command -v rsvg-convert >/dev/null 2>&1; then
    echo "rsvg"
    return
  fi
  for chrome in chromium google-chrome chrome "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"; do
    if [[ -x "$chrome" ]] || command -v "$chrome" >/dev/null 2>&1; then
      echo "chrome:$chrome"
      return
    fi
  done
  echo ""
}

convert_one() {
  local in="$1"
  local out="$2"
  local converter="$3"

  case "$converter" in
    rsvg)
      if [[ "$PNG_BG" == "transparent" ]]; then
        rsvg-convert --width="$PNG_WIDTH" --keep-aspect-ratio "$in" -o "$out"
      else
        rsvg-convert --width="$PNG_WIDTH" --keep-aspect-ratio --background-color="$PNG_BG" "$in" -o "$out"
      fi
      ;;
    chrome:*)
      local chrome_bin="${converter#chrome:}"
      local tmp_html
      tmp_html=$(mktemp -t svg-to-png.XXXXXX.html)
      local svg_b64
      svg_b64=$(base64 < "$in" | tr -d '\n')
      cat > "$tmp_html" <<HTML
<!DOCTYPE html><html><head><meta charset="utf-8">
<style>html,body{margin:0;padding:0;background:${PNG_BG};} img{display:block;width:${PNG_WIDTH}px;height:auto;}</style>
</head><body><img src="data:image/svg+xml;base64,${svg_b64}"></body></html>
HTML
      "$chrome_bin" --headless --disable-gpu --hide-scrollbars \
        --window-size="$PNG_WIDTH",2000 \
        --default-background-color=00000000 \
        --screenshot="$out" "file://$tmp_html" >/dev/null 2>&1
      rm -f "$tmp_html"
      ;;
    *)
      die "unknown converter $converter"
      ;;
  esac
  printf '  wrote %s\n' "$out"
}

main() {
  [[ $# -ge 1 ]] || die "usage: $0 <file.svg|directory> [output.png]"

  local converter
  converter=$(find_converter)
  [[ -n "$converter" ]] || die "no converter found. Install rsvg-convert (brew install librsvg) or have chromium / google-chrome on PATH."

  printf 'svg-to-png: using %s, width=%s, bg=%s\n' "${converter%%:*}" "$PNG_WIDTH" "$PNG_BG" >&2

  local input="$1"

  if [[ -d "$input" ]]; then
    [[ $# -eq 1 ]] || die "directory mode does not accept an output path"
    local count=0
    while IFS= read -r -d '' svg; do
      convert_one "$svg" "${svg%.svg}.png" "$converter"
      count=$((count + 1))
    done < <(find "$input" -maxdepth 1 -type f -name '*.svg' -print0)
    [[ $count -gt 0 ]] || die "no .svg files in $input"
    printf 'svg-to-png: converted %d file(s)\n' "$count" >&2
    return
  fi

  [[ -f "$input" ]] || die "$input not found"
  local output="${2:-${input%.svg}.png}"
  convert_one "$input" "$output" "$converter"
}

main "$@"
