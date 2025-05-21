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

#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "Please run the script as root (sudo)." 
   exit 1
fi

echo "📦 Installing Zsh..."
pacman -S --noconfirm zsh

echo "⚙️ Setting Zsh as the default shell..."
chsh -s $(which zsh)

echo "🔄 Log out and log back in to activate Zsh."

echo "🛠️ Downloading and installing Oh My Zsh..."
su -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

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
