#/bin/bash
cd ~
clear
echo "Installing dependencies..."
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y git vlc

# Check if there is a directory called "HeadlessLooper" in currect directory
# If not, clone the repo
if [ ! -d "HeadlessLooper" ]; then
    git clone https://github.com/1fc0nfig/HeadlessLooper.git
    CLONED=true
fi

# Change directory to HeadlessLooper
cd HeadlessLooper

# If the repo was just cloned, we don't need to update it
if [ "$CLONED" = true ]; then
    echo "Installing HeadlessLooper..."
else
    echo "Updating HeadlessLooper..."
    sudo git pull
fi

sudo chmod +x videolooper.sh

echo "Creating service file..."
# change the service file to point to the correct path
sudo sed -i "s|ExecStart=.*|ExecStart=$(pwd)/videolooper.sh|g" headlesslooper.service
sudo sed -i "s|WorkingDirectory=.*|WorkingDirectory=$(pwd)|g" headlesslooper.service


# Check for existing service file
# If there is one, remove it
if [ -f "/etc/systemd/system/headlesslooper.service" ]; then
    echo "Removing existing service file..."
    sudo systemctl stop headlesslooper.service
    sudo systemctl disable headlesslooper.service
    sudo rm /etc/systemd/system/headlesslooper.service
fi

echo "Installing service..."
sudo cp headlesslooper.service /etc/systemd/system/headlesslooper.service
sudo systemctl enable headlesslooper.service
sudo systemctl start headlesslooper.service

echo "Done!"

# TODO: For fresh install - check if the disk is partitioned correctly, create a mounting point at /mnt/MEDIA,
# edit fstab for automounting, mount, extend the rootfs to fill the disk, reboot
# 