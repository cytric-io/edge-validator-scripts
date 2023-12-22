#!/bin/bash

EC2_PUBLIC_IP=$1


FUND_AMOUNT="200000"

echo "Installing dependencies..."
echo
echo

# Install dependencies
sudo apt install wget
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Install Go
wget https://golang.org/dl/go1.19.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Clone and build polygons-sdk
git clone https://github.com/0xPolygon/polygon-edge && cd polygon-edge
echo "Building Go executable, please wait..."
go build main.go

# Add the current directory to PATH in .bashrc
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc

# Apply changes
source ~/.bashrc