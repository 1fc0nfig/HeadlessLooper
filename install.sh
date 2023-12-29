sudo apt update -y
sudo apt upgrade -y
sudo apt install -y git vlc

# Check if there is a directory called "HeadlessLooper" in currect directory
# If not, clone the repo
if [ ! -d "HeadlessLooper" ]; then
    git clone https://github.com/1fc0nfig/HeadlessLooper.git
fi

# Change directory to HeadlessLooper
cd HeadlessLooper

sudo mkdir /boot/Videos
sudo cp headlesslooper.service /etc/systemd/system/headlesslooper.service
sudo systemctl enable headlesslooper.service
