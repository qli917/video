#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  echo "Usage: $0 <video.mp4>" >&2
  echo "Validate codec, dimensions, fps, pixel format, SAR, DAR, duration and audio." >&2
}

command -v ffprobe >/dev/null 2>&1 || { echo "Error: ffprobe is required." >&2; exit 127; }
[[ $# -eq 1 ]] || { usage; exit 64; }
file=$1
[[ -f "$file" ]] || { echo "Error: video not found: $file" >&2; exit 66; }

field() {
  ffprobe -v error -select_streams v:0 -show_entries "stream=$1" -of default=nw=1:nk=1 "$file" | head -n1
}

codec=$(field codec_name)
width=$(field width)
height=$(field height)
fps=$(field r_frame_rate)
pix_fmt=$(field pix_fmt)
sar=$(field sample_aspect_ratio)
dar=$(field display_aspect_ratio)
duration=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$file")
audio=$(ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=nw=1:nk=1 "$file" | head -n1 || true)

printf 'codec=%s\nwidth=%s\nheight=%s\nfps=%s\npix_fmt=%s\nSAR=%s\nDAR=%s\nduration=%s\naudio=%s\n' \
  "$codec" "$width" "$height" "$fps" "$pix_fmt" "$sar" "$dar" "$duration" "${audio:-missing}"

fail=0
[[ "$codec" == h264 ]] || { echo "Error: expected H.264 video." >&2; fail=1; }
[[ "$width" == 1080 && "$height" == 1920 ]] || { echo "Error: expected 1080x1920." >&2; fail=1; }
[[ "$fps" == 30/1 || "$fps" == 30000/1000 ]] || { echo "Error: expected 30fps." >&2; fail=1; }
[[ "$pix_fmt" == yuv420p ]] || { echo "Error: expected yuv420p." >&2; fail=1; }
[[ "$sar" == 1:1 ]] || { echo "Error: expected SAR 1:1." >&2; fail=1; }
[[ "$dar" == 9:16 ]] || { echo "Error: expected DAR 9:16." >&2; fail=1; }
[[ -n "$audio" ]] || { echo "Error: audio stream is missing." >&2; fail=1; }
awk -v d="$duration" 'BEGIN {exit !(d > 0)}' || { echo "Error: invalid duration." >&2; fail=1; }

(( fail == 0 )) || exit 1
echo "PASS: mobile export matches the required specification."
