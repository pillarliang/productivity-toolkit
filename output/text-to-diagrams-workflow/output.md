# text-to-diagrams 工作流详解

![Figure 1 · Flowchart](output/figure-1-flowchart.svg)
*Step 1 的判断决定整条流水线是否启动 — 它戴上焦点色, 因为这一关挡住了所有不必要的图。Step 6 是可选叉路, Step 7 失败则沿虚线回到 Step 4 重渲染。*

## Step 0 · 读 style 文件
始终先读 references/style.md。提取 12 个 token 值 (paper, near-black, olive, stone, brand, brand-tint, up, down 等) 和两套字体栈 (serif, mono)。如果用户指定 "use style-<name>.md for this run",改读对应文件。

## Step 1 · 判断是否需要画图
关键问题: "一段写得好的段落能否比这张图教会读者更多?" 如果 "能",告诉用户文本没有足够结构,不画。

## Step 2 · 读图表目录
始终读 references/diagrams.md,里面有 17 种图的完整选型表 (Architecture / Flowchart / Sequence / ER / Quadrant / Pyramid / Bar / Line / Donut / State machine / Timeline / Swimlane / Tree / Layer stack / Venn / Candlestick / Waterfall),颜色 token,类型专属约定,反模式列表。不能凭记忆选。

## Step 3 · 规划图表
1. 通读全文。
2. 检测输入模式: 文本含 # 标题、围栏代码块、或 3 个以上列表项 → markdown 模式; 否则 → 纯文本模式。边界情况默认 markdown。
3. 列出每条带结构的 claim (层级、量级、方向、顺序、交集、分解)。
4. 把属于同一张图的 claim 分组。
5. 每组按"主导关系"选图类型。
6. 段落能教得更好的组,丢掉。
7. 让源文本决定数量 — 不设上限。每张图必须独立通过 Step 1。超过 6 张时,在页面上按章节分组。
8. 写下计划: 页面标题、可选章节标题、每张图的 (类型、标题、内容、焦点、可选 caption、anchor)。

Anchor 字段 (markdown 模式必填): end-of-section / after-heading / after-paragraph / append。

## Step 4 · 渲染每张图
对计划中每一项:
1. 打开 templates/<type>.html 模板
2. 提取 <svg>...</svg> 块,保留 viewBox
3. 编辑 <text> 和 <rect> 值
4. 应用 style.md 的值 (而非模板默认值)
5. 应用 diagrams.md § 4 的编辑规则: 坐标除尽 4、最多 3 档宽度、字号 7/9/12、箭头端点精确落在节点边
6. 应用 focal 规则: 1-2 个元素用 brand-tint 填充 + brand 描边,其他中性

![Figure 3 · Layer stack](output/figure-3-layer-stack.svg)
*渲染层是焦点 — 上面三层只决定画什么、装什么、检查什么; 下面两层只提供原料。真正把 SVG 落到磁盘的, 是 Step 4 的编辑动作。*

## Step 5 · 组装并写输出
始终产出三种文件:
A. 合并 HTML 页 (复制 page-shell.html, 替换占位符, >6 张图时分章节, 默认 output.html)
B. 每张图独立 SVG (默认 output/figure-<N>-<type>.svg)
C. Markdown 文件 (markdown 源模式: 逐字保留源文本,在 anchor 处插入图块; 纯文本模式: 合成新 md 文件镜像 HTML 页)
若用户 "skip individual SVGs" 或指定单文件路径,省略 B 和 C。

![Figure 2 · Swimlane](output/figure-2-swimlane.svg)
*中间的 Skill 泳道承担全部判断与编辑 — 这就是焦点。Step 4 在焦点泳道里再获焦点描边, 因为它把模板真正变成 SVG。Output 泳道只在 Step 5/6 才出现, 体现"在线生成、最后落盘"的特征。*

## Step 6 · 可选: SVG 转 PNG
仅在用户明确要求时调用 tools/svg-to-png.sh。

## Step 7 · 交付前自检
- 每张图恰好 1-2 个焦点
- 焦点颜色不与 caption 矛盾
- 箭头端点落在节点边上
- 所有坐标除尽 4
- 无 box-shadow / gradient / border-radius > 10px
- 无 emoji / 装饰图标
- style.md 值已应用
- 每张图的 SVG 文件已写
- output.md 已写
- 所有图片路径都对应实际文件
- markdown 模式下,每个 anchor 要么命中,要么有降级注释 (无静默丢失,无重复插入)

![Figure 4 · State machine](output/figure-4-state-machine.svg)
*Plan Drafted 是焦点状态 — 大部分失败和分流都发源于此。No-structure 是 Step 1 的硬否决, Anchor-fallback 是 Step 5 的温和降级 (写文件但加 audit 注释), QA-fail 则把流程退回到 Diagrams Rendered 重画。*
