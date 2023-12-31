#!/bin/bash

# Set the path to the directory containing your videos and images
media_directory="/mnt/MEDIA"

# Path to the "Media not found" image
no_media_image="media-not-found.jpg"

# Create an empty array to store media files
media_files=()

# List all video and image files in the directory
for f in "$media_directory"/*; do
    if [[ $f == *.mp4 || $f == *.avi || $f == *.mkv || $f == *.mov || $f == *.jpg || $f == *.png || $f == *.gif ]]; then
        media_files+=("$f")
    fi
done

# Check if there are any media files
if [ ${#media_files[@]} -eq 0 ]; then
    # Use the "Media not found" image if no media files are found
    media_files=("$no_media_image")
fi

# Echo the media files for debugging
echo "Media files to play: ${media_files[*]}"

# VLC command
vlc_command=(
    cvlc 
    --intf dummy 
    --no-osd 
    --loop 
    --fullscreen 
    "${media_files[@]}"
)

# Echo the full VLC command for debugging
echo "Running command: ${vlc_command[*]}"

# Run the VLC command in the background
"${vlc_command[@]}"