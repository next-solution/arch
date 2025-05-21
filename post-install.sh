#!/bin/bash

echo "Installing Dev tools..."
sudo pacman -S --noconfirm wezterm
sudo pacman -S --noconfirm --needed base-devel git

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
