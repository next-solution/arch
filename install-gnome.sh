#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing GNOME Shell and GDM..."
sudo pacman -S --noconfirm gnome-shell gdm

echo "Installing essential GNOME applications..."
sudo pacman -S --noconfirm gnome-control-center nautilus

echo "Enabling GDM..."
sudo systemctl enable gdm

echo "Installing Dev tools..."
sudo pacman -S --noconfirm wezterm
sudo pacman -S --noconfirm --needed base-devel git

echo "Cloning Paru repository..."
git clone https://aur.archlinux.org/paru.git

echo "Entering Paru directory..."
cd paru

echo "Building and installing Paru..."
makepkg -si --noconfirm
cd..
rm -rf paru
echo "alias yay='paru'" >> ~/.bashrc
source ~/.bashrc

paru -S --noconfirm brave-bin

echo "Installation completed. GNOME and NetworkManager have been successfully configured!"
