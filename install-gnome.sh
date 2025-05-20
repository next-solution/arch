#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing GNOME Shell and GDM..."
sudo pacman -S --noconfirm gnome-shell gdm

echo "Installing essential GNOME applications..."
sudo pacman -S --noconfirm gnome-control-center gnome-terminal nautilus

echo "Enabling GDM..."
sudo systemctl enable gdm
sudo systemctl start gdm

echo "Installing NetworkManager..."
sudo pacman -S --noconfirm networkmanager

echo "Enabling NetworkManager..."
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

echo "Installing NetworkManager Applet..."
sudo pacman -S --noconfirm network-manager-applet

echo "Installation completed. GNOME and NetworkManager have been successfully configured!"
