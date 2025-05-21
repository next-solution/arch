#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing GNOME Shell and GDM..."
sudo pacman -S --noconfirm gnome-shell gdm

echo "Installing essential GNOME applications..."
sudo pacman -S --noconfirm gnome-control-center nautilus

echo "Enabling GDM..."
sudo systemctl enable gdm

echo "📦 Installing Zsh..."
sudo pacman -S --noconfirm zsh

echo "⚙️ Setting Zsh as the default shell..."
chsh -s $(which zsh)

echo "🔄 Log out and log back in to activate Zsh."

echo "Installation completed!"
