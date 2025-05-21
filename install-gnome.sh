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

echo "📦 Installing Zsh..."
sudo pacman -S --noconfirm zsh

echo "⚙️ Setting Zsh as the default shell..."
chsh -s $(which zsh)

echo "🔄 Log out and log back in to activate Zsh."

echo "🛠️ Downloading and installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🎨 Configuring theme and plugins..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc

echo "✨ Updating shell..."
source ~/.zshrc

echo "Cloning Paru repository..."
git clone https://aur.archlinux.org/paru.git

echo "Entering Paru directory..."
cd paru

echo "Building and installing Paru..."
makepkg -si --noconfirm
cd..
rm -rf paru
echo "alias yay='paru'" >> ~/.zshrc
source ~/.zshrc

paru -S --noconfirm brave-bin

echo "Installation completed!"
