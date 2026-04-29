# 总结

本次会议围绕新的 agent 架构、APP 4.0 产品规划、分工安排、能力平移、定制决策及收费模式等内容展开讨论，明确了各方面的关键结论和后续工作方向，内容如下：

* **技术架构介绍**

  * **agent 架构概述**

    * 架构层级：新的 agent 架构最上层是 Sigma agent 上的 master agent，目前无编排能力，主要负责简单 QA 回答和调度分发任务给 worker agent。下层的 worker agent 承担所有复杂业务，是架构重点。

    * 意图识别不确定：master agent 的意图识别分类及对应 worker agent 不确定，可能直接拉起 worker agent 并选择工具执行任务，也可能定制特殊 agent，如垂直领域的 vertical agent。

    * Sandbox 应用：worker agent 若需要 Sandbox，master agent 会拉起 task 启动 Sandbox，将 worker agent 放入其中。Sandbox 类似虚拟机，有管理和文件系统，可执行脚本，但目前能想到的应用场景较少。

    * 恢复能力：Sandbox 有恢复能力，worker agent 运行中的中间结果会实时保存到文件系统，需要时可从文件系统恢复继续运行。

  * **context 与 memory 系统**

    * 定义待明确：context 加 memory 系统的检索能力主要在许航处，但哪些内容放入 context 以及 memory 的形式还在定义中。memory 主要是 agent 的中间产物，如 claude code、openclaw 产生的文件。

    * 数据利用可能性：目前梳理出转写的 outline 可用于精准按 topic 切分 summary，总 summary 生成过程中可能产生的 overview 能让 agent 快速了解文件内容，提高文件检索精准度。

    * 参考项目：UU（邓晓悦）提到李博项目输出的结构化 overview 可参考，其包含会议类型等信息，但 summary 0.5 目前仅用于该项目，放入 context 有多种研究方向待确定。

    * 多级索引建设：context 会包含更多 Metadata，如文件时长、参会人等结构化信息，summary 也可能有更多结构化内容，未来会构建多级索引，提高检索准确性。

* **分工安排**

  * **框架搭建**：田丰团队负责搭建框架，包括 master agent、运行在 Sandbox 里的 worker agent 以及管理 worker agent 的 task manager。

  * **李振工作内容**

    * context 梳理：考虑哪些 context 可提供给 agent 使用。

    * MD 生成：参与 agent 用的 MD 生成相关工作。

    * summary 与 ask 工作：重点关注 summary 加 ask 方面，包括能力平移和 SQL 化，梳理确定和不确定的平移内容。

  * **垂直领域调研**：满少晨和 Tony 分别调研法律和咨询方向的 vertical agent，未来分工可能弱化，大家围绕架构开展工作，确定李坤负责检索部分。

* **产品规划**

  * **APP 4.0 定位**：APP 4.0 是新老交接过程，不会全面转向 agent，会保留部分 3.0 功能，如 file list。

  * **agent 页面**：ask 和 summary 可能统一为 agent 页面，agent 贯穿 APP 4.0 和 Sigma，需有统一管理页面，用户行为在各入口触发后统一管理。

  * **页面设计不确定**：global ask 与 ask agent 是否合并不确定，APP 4.0 设计的激进程度影响具体页面呈现，目前还需进一步规划。

* **能力平移**

  * **技术改造**：ask 能力平移技术上采用 agent 方式，确保平移后在测试集上的准确率不低于 80%。

  * **老用户功能支持**：老用户的功能需求必须支持，可考虑技术或产品平移，重点是保证用户能继续使用原有功能。

  * **产品形态变化**：产品形态上，ask 界面可能改变，但功能保留，交付体验不同。

* **定制决策**

  * **定制原则**：若 worker agent 加 tools 能满足场景则不定制，否则需定制 worker agent，优先考虑输出质量，成本和效率问题后续再考虑。

  * **判断方法**：判断是否定制可看 service 所需工具，若模型能自主选择工具完成任务且无需编排链路，则使用原生支持；否则考虑定制。

  * **成本与效率**：定制可提高效率、降低成本，但目前优先保证输出质量，后续可通过加 Pro cache、prompt、context 卸载等方案降低成本。

* **收费模式**：未来收费模式会改变，上传音频、转写总结按时长收费，使用复杂 agent 能力按 TOKEN 收费，取消 unlimited 方案。

* **其他讨论**

  * **多模态处理**：Ting（王婷）提出后续 agent 的 context 应支持多模态信息，如截图、文件、语音、照片等，但短期内难以启动，现有架构可按多模态准备。

  * **Web search**：李振着急将 Web search 加入架构，老板同意尽快推进，该功能已在 plaudtools 中添加。

  * **query 梳理**：Ting（王婷）建议梳理现有 query，基于现有业务架构尝试解决问题，搭建 demo 或进行链路串起尝试，以满足用户正常问题需求。

  * **编排问题**：目前 master agent 无编排能力，复杂业务需拉起 worker agent，worker agent 可调用多个 SUB agent，但编排部分未设计，由各服务自行处理。

  * **用户体验**：Ting（王婷）认为 3.0 到 4.0 过渡不宜过大，需保留基础产品形态，如推荐问题、提示信息等，以保证用户能理解和使用。

  * **架构效果**：李振认为目前设计的架构未提升 AI service 能力，主要提升在于 context 和 memory 的检索精准度，未来维护重点在 worker agent 定制和 skill 补充。

# 待办

* [ ] 功能平移确认：与老板沟通确认 APP 4.0 是否支持 ask 功能平移，确保老用户功能需求得到满足，且测试集准确率不低于 80% `@Ting(王婷)`

* [ ] 信息对齐整理：与研发内部团队成员对齐 recently memory 想法，将其整理成基础文档，收敛各方意见，对 ask 技术进行 agent 改造（来自Ting(王婷)） `@Luke(李振)`
