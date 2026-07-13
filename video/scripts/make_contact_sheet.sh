#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  echo "Usage: $0 <frames-dir> [output.jpg]" >&2
  echo "Build a 5-column contact sheet from frame_*.jpg files." >&2
}

command -v ffmpeg >/dev/null 2>&1 || { echo "Error: ffmpeg is required." >&2; exit 127; }
[[ $# -ge 1 && $# -le 2 ]] || { usage; exit 64; }

frames_dir=$1
output=${2:-contact_sheet.jpg}
[[ -d "$frames_dir" ]] || { echo "Error: frames directory not found: $frames_dir" >&2; exit 66; }

count=$(find "$frames_dir" -maxdepth 1 -type f -name 'frame_*.jpg' | wc -l)
(( count > 0 )) || { echo "Error: no frame_*.jpg files in $frames_dir" >&2; exit 65; }
cols=5
rows=$(( (count + cols - 1) / cols ))
mkdir -p "$(dirname "$output")"

ffmpeg -y -hide_banner -loglevel error \
  -pattern_type glob -i "$frames_dir/frame_*.jpg" \
  -vf "scale=216:384:force_original_aspect_ratio=decrease,pad=216:384:(ow-iw)/2:(oh-ih)/2:black,tile=${cols}x${rows}:padding=4:margin=4" \
  -frames:v 1 "$output"

[[ -s "$output" ]] || { echo "Error: contact sheet was not created." >&2; exit 1; }
echo "Wrote contact sheet: $output ($count frames, ${cols}x${rows})"
