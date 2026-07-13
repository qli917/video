---
name: douyin-video-producer
description: Produce short, evidence-driven Douyin videos using real data, real sources, real recordings, strong hooks, interaction design, anti-PPT quality control, mobile-safe export, and iterative metric review. Use for AI tool demos, Codex workflows, tutorials, project promos, analytics reviews, before-and-after edits, GitHub project videos, or any Douyin production that must be rendered and improved from real performance data.
---

# Douyin Video Producer

## 1. 适用范围

用于抖音 AI 工具视频、Codex 实战视频、AI 视频教程、项目宣传片、数据复盘视频、前后对比视频、工作流演示视频和 GitHub 项目宣传视频。

不要用于没有真实内容的工具介绍、纯 Skill 清单、纯 UI 宣传片、白底知识卡、高级 PPT 翻页或单纯堆特效的视频。

## 2. 核心原则

**Skill 不是内容，Skill 只是处理内容的工具。**

按证据链制作：真实问题 → 真实资料 → 真实冲突 → 真实过程 → 真实修正 → 真实结果。先填写 `templates/content-brief.md` 和 `templates/source-package.md`。没有足够真实内容包时，停止视频生成并请求补充；禁止用虚构 UI 强行补齐。

需要判断素材是否合格时读取 [content-first.md](references/content-first.md)。

## 3. 默认时长与密度

- 默认 20—35 秒；只有真实内容无法讲清楚时才延长。
- 每 2—3 秒至少出现新信息、新动作、新对比、新结果或新证据。
- 禁止长标题页、Skill 介绍页、重复说明、等待/加载镜头和总结页凑时长。
- 一条视频只解决一个具体问题，提炼 1—3 个核心结论。

## 4. 内容优先工作流

1. 定义具体问题。
2. 收集真实数据和资料。
3. 建立 source package 并完成脱敏。
4. 分析公开参考案例，提取钩子、结构、结果证明和互动方式。
5. 提炼 1—3 个核心结论。
6. 使用 `templates/shot-list.md` 生成镜头清单。
7. 按导演式方法录制真实动作。
8. 剪辑真实录屏、失败画面、修改动作和 Before / After。
9. 加入口播并用 Whisper 校对时间轴。
10. 抽帧质检，按 anti-PPT 规则修改直至通过。
11. 检查抖音手机安全区。
12. 用脚本导出手机兼容 MP4，并运行 ffprobe。
13. 准备发布文案并发布。
14. 收集发布后数据，定位最大流失点。
15. 下一版只测试 1—3 个变量。

按阶段读取：视觉设计用 [visual-direction.md](references/visual-direction.md)，录屏用 [recording-guide.md](references/recording-guide.md)，导出用 [mobile-export.md](references/mobile-export.md)，复盘用 [iteration-framework.md](references/iteration-framework.md)。

## 5. Skills 协作

- **agent-browser**：搜索公开案例；记录标题、封面、钩子和互动方式；不复制作品、不高频抓取、不绕过验证码，遇验证码立即停止。
- **OpenAI Image**：只生成必要的原创主视觉或极短转场；不替代真实内容；装饰性 AI 画面最多占 5%—10%。
- **HyperFrames**：数据高亮、局部动效、元素延续转场；禁止卡片轮播。
- **Remotion**：时间线、镜头节奏、运镜、前后对比、手机窗口切换。
- **Whisper**：口播转写和时间轴校对；默认不生成底部逐句字幕。
- **video-use**：抽帧；检查 PPT 感、内容密度、前 5 秒和手机安全区。
- **FFmpeg**：音频合成、H.264、yuv420p、faststart 和手机兼容导出。
- **create-promo-video**：组织钩子、冲突、过程、结果和互动结尾；不得把 Skill 名称变成内容主体。

## 6. 去 PPT 感硬规则

禁止一页一个 Skill、一页一个观点、白底知识卡、深色卡片 PPT、科技 UI 卡片轮播、大面积空白、满屏小字、纯文字页、终端/时间线长时间静止、结尾总结页、只靠文字解释，以及让小黑人当主角、口播或连续动画。

默认要求：

- 真实内容占比至少 70%—80%。
- UI 只辅助解释；装饰性素材不超过 10%。
- 每个镜头有明确主体和真实变化。
- 最终成片必须连续播放。
- 至少有一组 Before / After。
- 主视觉优先占画面 55%—80%，背景持续有真实信息。

每次抽帧都运行 [anti-ppt-checklist.md](checklists/anti-ppt-checklist.md)。详细识别标准见 [anti-ppt-rules.md](references/anti-ppt-rules.md)。若失败，修改并重新渲染，不得只写报告。

## 7. 导演式录屏

不要录完整操作。每段原始录屏 2—6 秒，最终保留 0.8—2.5 秒，只记录一个明确动作。

录前打开正确页面、定位关键区域、确定鼠标路径、开始状态和结束状态。不要录找页面、加载、等待、误点、无关滚动或隐私数据。详细流程见 [recording-guide.md](references/recording-guide.md)。

## 8. 抖音互动设计

评论设计必须进入视频结构。禁止只写“评论：流程”。先给明确回报，再给低门槛关键词，例如：

> 想要 10 条参考链接和完整分析文档？评论：分析。

或：

> 想要完整提示词和工程结构？评论：流程。

支持 A/B/C/D 选择题、痛点征集、下一期共创、关键词领取和“按最高票重做”。不要只索取互动。需要选择 CTA 类型时读取 [interaction-design.md](references/interaction-design.md)。

## 9. 数据复盘

发布后至少记录播放量、推荐页占比、2 秒跳出率、5 秒留存、平均播放时长、完播率、点赞率、收藏率、评论率、分享率和吸粉率。

判断优先级：2 秒跳出 → 5 秒留存 → 平均播放 → 完播率 → 收藏率 → 评论率 → 播放量。定位最大逐秒流失点和相对同类差距最大的时间点。每版只测试 1—3 个变量。计算方法见 [retention-metrics.md](references/retention-metrics.md)。

## 10. 手机安全区

默认画布 1080×1920。安全边距：左 72px、右 180px、上 140px、下 300px。关键文字不得进入右侧互动按钮区、底部作品描述区或顶部状态区。所有关键元素必须自动缩放并使用 `overflow: hidden`，不能溢出屏幕。检查方法见 [douyin-safe-area.md](references/douyin-safe-area.md)。

## 11. 导出要求

默认导出 1080×1920、30fps、H.264、yuv420p、faststart、SAR 1:1、DAR 9:16，并保留 AAC 音频。运行：

```bash
scripts/mobile_compatible_export.sh input.mp4 final_video.mp4
scripts/ffprobe_check.sh final_video.mp4
scripts/extract_frames.sh final_video.mp4 review_frames
scripts/make_contact_sheet.sh review_frames contact_sheet.jpg
```

必须实际渲染最终 MP4、用 ffprobe 检查并抽帧；不能停在代码或计划阶段。

## 12. 最终输出

每次运行至少输出：

- `content_brief.md`
- `source_package.md`
- `shot_list.md`
- `voiceover_script.md`
- `video_structure.md`
- `quality_report.md`
- `review_frames/`
- `final_video.mp4`

最终发布前完成 `checklists/pre-production.md`、`checklists/anti-ppt-checklist.md`、`checklists/mobile-safe-area-checklist.md` 和 `checklists/publish-checklist.md`。发布后使用 `checklists/post-publish-review.md`。
