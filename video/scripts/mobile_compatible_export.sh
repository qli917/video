#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  echo "Usage: $0 <input-video> <output.mp4>" >&2
  echo "Export 1080x1920@30 H.264/yuv420p + AAC with MP4 faststart." >&2
}

command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg is required." >&2; exit 127; }
[[ $# -eq 2 ]] || { usage; exit 64; }

input=$1
output=$2
[[ -f "$input" ]] || { echo "Error: input video not found: $input" >&2; exit 66; }
[[ "$output" == *.mp4 ]] || { echo "Error: output must end in .mp4" >&2; exit 65; }

mkdir -p "$(dirname "$output")"
ffmpeg -y -hide_banner -loglevel error -i "$input" \
  -map 0:v:0 -map 0:a:0? \
  -vf "scale=1080:1920:force_original_aspect_ratio=decrease:flags=lanczos,pad=1080:1920:(ow-iw)/2:(oh-ih)/2:black,setsar=1,fps=30,format=yuv420p" \
  -c:v libx264 -preset medium -crf 18 -pix_fmt yuv420p -color_range tv \
  -c:a aac -b:a 192k -ar 48000 \
  -movflags +faststart "$output"

echo "Wrote mobile-compatible video: $output"
