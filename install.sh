#!/bin/bash
# ono-sendai installer

echo "Installing..."



### Shell (terminator + zsh + oh-my-zsh + plugins + PowerLevel9k theme + hack font + powerline icons)

# install terminator + zsh + hack font + powerline icons
sudo apt-get install terminator zsh fonts-hack-ttf fonts-powerline -y

# config terminator
mkdir -p ~/.config/terminator/
cp terminator.config ~/.config/terminator/config
sudo sed -i 's/terminal.vte.feed_child(command, len(command))/terminal.vte.feed_child(command.encode("utf-8"))/g' /usr/share/terminator/terminatorlib/plugins/custom_commands.py 
sudo py3clean /usr/share/terminator/terminatorlib/plugins
sudo python -m compileall /usr/share/terminator/terminatorlib/plugins

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install theme PowerLevel9K for oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install syntax highlighting plugin for oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# install autosuggestion plugin for oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# update zsh config file
cp .zshrc ~/.zshrc

# switch default shell to zsh
echo "[!] To continue with installation, exit zsh once oh-my-zsh loads"
chsh -s $(which zsh)



### Utilities

# install bat (cat replacement with syntax-highlighting) and clean up
wget --content-disposition https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb
sudo dpkg -i bat_0.13.0_amd64.deb
rm bat_0.13.0_amd64.deb

# install grc (general colourizer) and clean up
git clone https://github.com/garabik/grc.git
cd grc
sudo ./install.sh
cd ..
rm -Rf grc

# install vs code
sudo apt-get install apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code



# go hack stuff
echo "ono-sendai env installed, log out and log in again, use terminator and go hack stuff x_x"
