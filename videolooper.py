import os
import subprocess

# Set the path to the directory containing your videos and images
media_directory = "/boot/Videos"

# Path to the "Media not found" image
no_media_image = "media-not-found.jpg"

# List all video and image files in the directory
media_files = [f for f in os.listdir(media_directory) if f.endswith(('.mp4', '.avi', '.mkv', '.mov', '.jpg', '.png', '.gif'))]

# Check if there are any media files
if not media_files:
    # Use the "Media not found" image if no media files are found
    media_paths = no_media_image
else:
    # Clear the Videos directory in current directory
    subprocess.run(['rm', '-rf', 'Videos/*'])
    # Copy all media files to Videos directory in current directory
    subprocess.run(['cp', '-r', media_directory, 'Videos'])
    # Change the media directory to the Videos directory in current directory
    media_directory = 'Videos'
    # Create a string with the paths of all media files, separated by spaces
    media_paths = ' '.join([os.path.join(media_directory, f) for f in media_files])

# VLC command
vlc_command = [
    'cvlc', 
    '--intf', 'dummy', 
    '--aout', 'alsa', 
    '--alsa-audio-device', 'hw:0,0', 
    '--no-osd', 
    '--loop', 
    '--fullscreen', 
    media_paths
]

# Run the VLC command
subprocess.run(vlc_command)