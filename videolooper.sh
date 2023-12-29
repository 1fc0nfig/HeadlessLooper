#!/bin/bash

# Set the path to the directory containing your videos and images
media_directory="/boot/Videos"

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
    media_paths=$no_media_image
else
    # Clear the Videos directory in current directory
    rm -rf Videos/*

    # Copy all media files to Videos directory in current directory
    cp -r "$media_directory"/* Videos/

    # Change the media directory to the Videos directory in current directory
    media_directory="Videos"

    # Create a string with the paths of all media files, separated by spaces
    media_paths=""
    for f in "${media_files[@]}"; do
        media_paths+="$media_directory/$(basename "$f") "
    done
fi

# VLC command
vlc_command=(
    cvlc 
    --intf dummy 
    --no-osd 
    --loop 
    --fullscreen 
    $media_paths
)

# Run the VLC command
"${vlc_command[@]}"
