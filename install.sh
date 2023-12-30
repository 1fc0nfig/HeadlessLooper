#/bin/bash

cd
clear
echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

clear
echo "Installing dependencies..."
sudo apt install -y git vlc

# Check if there is a directory called "HeadlessLooper" in currect directory
# If not, clone the repo
if [ ! -d "HeadlessLooper" ]; then
    echo "Cloning HeadlessLooper repo..."
    git clone https://github.com/1fc0nfig/HeadlessLooper.git
fi


# Change directory to HeadlessLooper
cd HeadlessLooper

echo "Updating HeadlessLooper..."
sudo git pull

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