#!/bin/bash

echo "Enabling GDM..."
sudo systemctl enable gdm

echo "Configuring Samba"
sudo mkdir /etc/samba
sudo touch /etc/samba/smb.conf
cd ~

echo "Cloning Paru repository..."
git clone https://aur.archlinux.org/paru.git

echo "Entering Paru directory..."
cd paru

echo "Building and installing Paru..."
makepkg -si --noconfirm
cd..
rm -rf paru

paru -S --noconfirm brave-bin
paru -S --noconfirm snap-pac-grub
paru -S --noconfirm heroic-games-launcher-bin

CONFIG_FILE="/etc/mkinitcpio.conf"
HOOKS_KEY="HOOKS=("
NEW_HOOK="grub-btrfs-overlayfs"

sudo cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
sudo sed -i "/^$HOOKS_KEY/ s/)/ $NEW_HOOK)/" "$CONFIG_FILE"
sudo mkinitcpio -P

echo "Installation completed!"
