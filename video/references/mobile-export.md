# Mobile Export

## 目标规格

- 1080×1920，30fps。
- H.264 + AAC。
- yuv420p。
- SAR 1:1，DAR 9:16。
- MP4 faststart。

## 导出

使用 `scripts/mobile_compatible_export.sh`：

```bash
scripts/mobile_compatible_export.sh input.mp4 final_video.mp4
```

脚本会缩放并补边到 1080×1920，强制 30fps、H.264、yuv420p、AAC 和 faststart。源视频比例不符时不拉伸。

## 验证

```bash
scripts/ffprobe_check.sh final_video.mp4
```

检查 codec、宽高、fps、pix_fmt、SAR、DAR、时长和音频流。任何关键项不符合时重新编码，不能只在报告中注明。

## 抽帧

```bash
scripts/extract_frames.sh final_video.mp4 review_frames
scripts/make_contact_sheet.sh review_frames contact_sheet.jpg
```

用手机尺寸查看联系表，确认文字没有裁切、右侧和底部 UI 不遮挡关键内容。
