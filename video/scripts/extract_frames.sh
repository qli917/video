#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  echo "Usage: $0 <input-video> [output-dir]" >&2
  echo "Extract one JPEG frame per second. Default output: review_frames/" >&2
}

command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg is required." >&2; exit 127; }
[[ $# -ge 1 && $# -le 2 ]] || { usage; exit 64; }

input=$1
output=${2:-review_frames}
[[ -f "$input" ]] || { echo "Error: input video not found: $input" >&2; exit 66; }

mkdir -p "$output"
rm -f "$output"/frame_*.jpg
ffmpeg -hide_banner -loglevel error -i "$input" \
  -vf "fps=1,scale=540:-2:flags=lanczos" \
  -q:v 2 "$output/frame_%04d.jpg"

count=$(find "$output" -maxdepth 1 -type f -name 'frame_*.jpg' | wc -l)
(( count > 0 )) || { echo "Error: no frames were extracted." >&2; exit 1; }
echo "Extracted $count frames to $output"
