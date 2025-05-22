#!/bin/zsh

cd ~

echo "🛠️ Downloading and installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🎨 Configuring theme and plugins..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc

echo "alias yay='paru'" >> ~/.zshrc

echo "✨ Updating shell..."
source ~/.zshrc

echo "Installation completed!"
