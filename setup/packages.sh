#!/bin/bash

# System
echo "Packages - System"
sudo sh -c 'echo "fastestmirror=True" >> /etc/dnf/dnf.conf'
sudo sh -c 'echo "defaultyes=True" >> /etc/dnf/dnf.conf'
sudo dnf install -y fedora-workstation-repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf distro-sync
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf install -y ngrep tcpdump vim xclip neofetch htop
sudo dnf install -y java-latest-openjdk-headless
# sudo dnf install -y snapd
# sudo ln -s /var/lib/snapd/snap /snap
# sudo systemctl enable snapd --now
# sudo snap refresh
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# sudo dnf install -y tlp tlp-rdw
# sudo systemctl enable tlp --now

# Nvidia
sudo dnf install -y akmod-nvidia
sudo dnf install -y xorg-x11-drv-nvidia-cuda

# Security
sudo dnf install -y clamav clamav-update
sudo sed -i '/Example/d' /etc/freshclam.conf
sudo freshclam
sudo systemctl enable clamav-freshclam.service --now
# clamscan --infected --remove --recursive /home
sudo dnf install -y clamtk

sudo dnf install -y firewalld
sudo systemctl unmask firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --remove-service=ssh --permanent --zone=home
sudo firewall-cmd --reload
sudo dnf install -y firewall-config

# sudo snap install authy --beta

# Browsers
echo "Packages - Browsers"
# sudo dnf config-manager --set-enabled google-chrome
# sudo dnf install -y google-chrome-stable

# GPG
echo "Packages - GPG"
sudo dnf install -y https://prerelease.keybase.io/keybase_amd64.rpm
run_keybase

# IDE
echo "Packages - IDE"
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install -y sublime-text


echo "Package - Visual Studio Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code

# Utilities
sudo flatpak install -y flathub org.standardnotes.standardnotes

sudo rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
sudo sh -c 'echo -e "[insync]\nname=insync repo\nbaseurl=http://yum.insync.io/fedora/\$releasever/\ngpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key" > /etc/yum.repos.d/insync.repo'
sudo dnf install -y insync

sudo dnf install -y meld unrar pdfarranger

# Videos
echo "Packages - Videos"
sudo dnf install -y celluloid
# sudo flatpak install -y shotcut kdenlive

# Fonts
echo "Packages - Fonts"
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo dnf install -y http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
sudo dnf install -y fira-code-fonts
sudo dnf install -y powerline-fonts

# Themes
sudo dnf install -y gnome-shell-theme-flat-remix

# YARN
# if [ -d "$HOME/.nvm" ]; then
#     echo "Packages - Node"

#     curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
#     sudo dnf install -y yarn
# fi
