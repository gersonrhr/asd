apt update
apt install parallel -y
apt install postgres -y
chmod +x *.sh
sudo fallocate -l 15G /swapfile2
sudo chmod 600 /swapfile2
sudo mkswap /swapfile2
sudo swapon /swapfile2
sudo swapon --show
