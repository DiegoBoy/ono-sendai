#!/bin/bash
# ono-sendai installer

# get rest of ono-sendai files
git clone https://github.com/DiegoBoy/ono-sendai.git ~/ono-sendai

# install zsh shell, powerline icons and terminator
apt-get install zsh fonts-powerline terminator -y

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install theme PowerLevel9K for oh-my-zsh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install syntax highlighting plugin or oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# install autosuggestion plugin or oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# install grc general colourizer and clean up
git clone https://github.com/garabik/grc.git ~/ono-sendai/grc
~/ono-sendai/grc/install.sh
rm -Rf ~/ono-sendai/grc

# update zsh config file
cp ~/ono-sendai/.zshrc ~/.zshrc

# switch default shell to zsh
chsh -s $(which zsh)

# update terminator config file
cp ~/ono-sendai/terminator.config ~/.config/terminator/config

# fix termiantor custom commands menu plugin
sed -i 's/terminal.vte.feed_child(command, len(command))/terminal.vte.feed_child(command.encode("utf-8"))/g' /usr/share/terminator/terminatorlib/plugins/custom_commands.py
py3clean /usr/share/terminator/terminatorlib/plugins
python -m compileall /usr/share/terminator/terminatorlib/plugins



##### install tools of the trade #####
git clone https://github.com/DiegoBoy/hephaestus.git ~/hephaestus && cd ~/hephaestus

### PrivEsc tools

# linux exploit suggester
git clone https://github.com/DiegoBoy/linux-exploit-suggester.git ~/hephaestus/PrivEsc/linux-exploit-suggester
ln -s ~/hephaestus/PrivEsc/linux-exploit-suggester/linux-exploit-suggester.sh ~/hephaestus/PrivEsc/les.sh



# go hack stuff
echo "ono-sendai env installed, log out and log in again, use terminator and go hack stuff x_x"