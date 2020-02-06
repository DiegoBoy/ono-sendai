#!/bin/bash
# ono-sendai installer

echo "Installing..."



### Shell (oh-my-zsh + plugins + theme PowerLevel9k)

# install zsh shell and powerline icons
sudo apt-get install zsh fonts-powerline -y

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install theme PowerLevel9K for oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install syntax highlighting plugin for oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# install autosuggestion plugin for oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# install grc general colourizer and clean up
git clone https://github.com/garabik/grc.git
grc/install.sh
rm -Rf grc

# update zsh config file
cp .zshrc ~/.zshrc

# switch default shell to zsh
chsh -s $(which zsh)

echo "[X] Shell"



### Terminal (terminator)

# install terminator
sudo apt-get install terminator -y

# update terminator config file
cp terminator.config ~/.config/terminator/config

# fix termiantor custom commands menu plugin
sed -i 's/terminal.vte.feed_child(command, len(command))/terminal.vte.feed_child(command.encode("utf-8"))/g' /usr/share/terminator/terminatorlib/plugins/custom_commands.py
py3clean /usr/share/terminator/terminatorlib/plugins
python -m compileall /usr/share/terminator/terminatorlib/plugins

echo "[X] Terminal"



# go hack stuff
echo "
ono-sendai env installed, log out and log in again, use terminator and go hack stuff x_x"
