#!/bin/bash

EC2_PUBLIC_IP=$1


FUND_AMOUNT="200000"

echo "Installing dependencies..."
echo
echo

# Install dependencies
sudo apt install wget
wget https://golang.org/dl/go1.21.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
source ~/.profile

# Clone and build polygons-sdk
git clone https://github.com/0xPolygon/polygon-edge && cd polygon-edge
echo "Building Go executable, please wait..."
go build -o polygon-edge main.go

# Move the binary to a directory in your PATH
sudo mv polygon-edge /usr/local/bin/
