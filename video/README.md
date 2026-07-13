# Douyin Video Producer

`douyin-video-producer` 是一个面向抖音 AI 短视频制作与数据迭代的 Codex Skill。它把真实资料、公开案例分析、导演式录屏、剪辑、去 PPT 质检、手机安全区、发布互动和数据复盘串成可重复执行的生产流程。

## 解决什么问题

传统 AI 视频容易先设计界面，再寻找内容，最后变成白底知识卡、深色科技卡片或一页一个观点的“高级 PPT”。本 Skill 反转顺序：先建立真实内容证据链，再决定镜头、录屏和动效。没有真实数据、真实过程或真实结果时，不允许用虚构 UI 顶替。

## 核心工作流

真实问题 → source package → 爆款案例分析 → 1—3 个结论 → shot list → 导演式录屏 → 真实素材剪辑 → Before / After → 口播校对 → anti-PPT 抽帧 → 安全区检查 → 手机兼容导出 → 发布 → 数据复盘 → 下一版实验。

## 安装

```bash
git clone git@github.com:qli917/video.git
```

将仓库内 `video/` 目录安装或链接到 Codex Skills 目录：

```bash
ln -s "$(pwd)/video/video" "${CODEX_HOME:-$HOME/.codex}/skills/douyin-video-producer"
```

重启 Codex 以加载新 Skill。

## Codex 使用方式

```text
Use the douyin-video-producer skill to create a 25-second Douyin video based on real analytics, real recordings, a visible before/after comparison, and a clear comment reward.
```

也可以直接说：

```text
使用 douyin-video-producer，把这组抖音 Excel 数据、旧视频和真实录屏制作成 28 秒成片；必须抽帧检查并输出手机兼容 MP4。
```

## 目录结构

```text
video/
├── SKILL.md
├── README.md
├── references/   # 内容、留存、互动、视觉、安全区、导出、迭代方法
├── templates/    # brief、素材包、镜头、口播、结构、复盘、质检、发布文案
├── checklists/   # 制作前、anti-PPT、安全区、发布、发布后复盘
├── scripts/      # 抽帧、联系表、手机导出、ffprobe 检查
└── examples/     # 可复用示例
```

## 示例命令

```bash
video/scripts/extract_frames.sh final_video.mp4 review_frames
video/scripts/make_contact_sheet.sh review_frames contact_sheet.jpg
video/scripts/mobile_compatible_export.sh preview.mp4 final_video.mp4
video/scripts/ffprobe_check.sh final_video.mp4
```

## 数据迭代方法

优先复盘 2 秒跳出、5 秒留存、平均播放和完播，再看收藏、评论和播放量。逐秒寻找最大流失点；每一版只测试 1—3 个变量，例如真实数据冲突开场、结果前置或明确评论回报。保留有效变量，删除无效镜头，再生成下一版。

本 Skill 不保证爆款，也不承诺具体播放量；它通过真实证据、更强留存结构、明确互动回报和可验证迭代，提高成功概率。
