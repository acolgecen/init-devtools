#!/bin/bash

GREEN='\033[0;32m'  # ANSI color code for green
YELLOW='\033[0;33m' # ANSI color code for yellow
RED='\033[0;31m'    # ANSI color code for red
NOCOLOR='\033[0m'   # No color / reset ANSI code

# FuNOCOLORtion to check the success of the last command
check_command() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Command executed successfully.${NOCOLOR}"
    else
        echo -e "${RED}Command failed.${NOCOLOR}"
        exit 1  # Exit the script if any command fails
    fi
}


# Ask for sudo upfront
echo -e "${YELLOW}This script requires sudo privileges. Please enter your password.${NOCOLOR}"
sudo -v
check_command
echo ""


# Update package list
echo -e "${YELLOW}Updating package list...${NOCOLOR}"
sudo apt update -y
check_command
sudo apt upgrade -y
check_command
echo ""


# Install Curl
echo -e "${YELLOW}Installing Curl...${NOCOLOR}"
sudo apt install -y curl
check_command
echo ""


# Install Git
echo -e "${YELLOW}Installing Git...${NOCOLOR}"
sudo apt install -y git
check_command
echo ""


# Configure Git
echo "Configuring Git..."
git config --global user.name "atilla"
git config --global user.email "atillacolgecen@gmail.com"
check_command
echo ""


# Install build-essential
echo -e "${YELLOW}Installing build-essential...${NOCOLOR}"
sudo apt install -y build-essential
check_command
echo ""


# Install KeePassXC
echo -e "${YELLOW}Installing KeePassXC...${NOCOLOR}"
sudo apt install -y keepassxc
check_command
echo ""


# Install Ansible
echo -e "${YELLOW}Installing Ansible...${NOCOLOR}"
sudo apt install -y ansible
check_command
echo ""


# Upgrade all packages to the latest version
echo -e "${YELLOW}Upgrading all packages...${NOCOLOR}"
sudo apt upgrade -y
check_command
echo ""


# Install Visual Studio Code repository and application
echo -e "${YELLOW}Installing Visual Studio Code...${NOCOLOR}"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code
check_command
echo ""


# Import Vivaldi GPG key
echo -e "${YELLOW}Importing Vivaldi GPG key...${NOCOLOR}"
wget -qO- http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
check_command
echo ""

# Update apt cache
echo -e "${YELLOW}Updating apt cache...${NOCOLOR}"
sudo apt update
check_command
echo ""

# Download Vivaldi package 
echo -e "${YELLOW}Downloading Vivaldi package to /tmp...${NOCOLOR}"
wget -qO /tmp/vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_4.1.2369.21-1_amd64.deb
check_command
echo ""

# Install Vivaldi 
echo -e "${YELLOW}Installing Vivaldi from /tmp...${NOCOLOR}"
sudo apt install -y /tmp/vivaldi.deb
check_command
echo ""


# Removing FireFox Browser
echo -e "${YELLOW}Removing FireFox Browser...${NOCOLOR}"
sudo snap remove firefox
check_command
echo ""


# Update package list
echo -e "${YELLOW}Updating package list...${NOCOLOR}"
sudo apt update -y
check_command
sudo apt upgrade -y
check_command
echo ""

# Clean up unused packages
echo -e "${YELLOW}Cleaning up unused packages...${NOCOLOR}"
sudo apt autoremove -y
check_command
echo ""


# Clean up apt cache
echo -e "${YELLOW}Cleaning up apt cache...${NOCOLOR}"
sudo apt clean
check_command
echo ""


# Finish message
echo -e "${YELLOW}All specified applications have been installed.${NOCOLOR}"
echo ""


# Prompt to reboot
read -p "Press any key to reboot your system now, or Ctrl+C to cancel..." -n1 -s
echo -e "\nRebooting the system..."
sudo reboot





