#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing snapper..."
sudo pacman --noconfirm -S snapper
sudo pacman --noconfirm -S btrfs-progs

sudo umount /.snapshots
sudo rm -r /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a

sudo pacman --noconfirm -S snap-pac

echo "Installing GNOME Shell and GDM..."
sudo pacman -S --noconfirm gnome-shell gdm

echo "Installing essential GNOME applications..."
sudo pacman -S --noconfirm gnome-control-center gnome-shell-extension-appindicator gnome-shell-extension-caffeine nautilus

echo "Enabling GDM..."
sudo systemctl enable gdm

echo "Installing Samba"
sudo pacman -S --noconfirm samba gvfs-smb
sudo mkdir /etc/samba
sudo touch /etc/samba/smb.conf

echo "📦 Installing Tools..."
sudo pacman -S --noconfirm zsh unrar

echo "Installing fonts..."
sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

echo "Installing Dev tools..."
sudo pacman -S --noconfirm ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-hack-nerd ttf-dejavu-nerd ttf-cascadia-code-nerd ttf-ubuntu-mono-nerd
sudo pacman -S --noconfirm wezterm
sudo pacman -S --noconfirm --needed base-devel git

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
