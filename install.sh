#!/bin/bash
# ono-sendai installer

# update repos first
sudo apt-get update > /dev/null



### Terminal
echo "[*] Installing terminal..."

# install terminator
sudo apt-get install -y terminator > /dev/null
mkdir -p ~/.config/terminator/
cp terminator.config ~/.config/terminator/config
echo "TerminalEmulator=terminator" > ~/.config/xfce4/helpers.rc


### Shell
echo "[*] Installing shell..."

# install zsh, fonts and icons
sudo apt-get install -y zsh fonts-hack-ttf fonts-powerline > /dev/null

# install oh-my-zsh
echo 'exit' | sh -c "$(curl -s -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null

# install theme PowerLevel9K
git clone -q https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install plugins
sudo apt-get install -y fzf > /dev/null
git clone -q https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone -q https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# update zsh config file
cp .zshrc ~/.zshrc
sudo cp .zshrc /root/.zshrc

# switch default shell to zsh
chsh -s $(which zsh)



### Utilities
echo "[*] Installing utilities..."

# install bat (cat replacement with syntax-highlighting) and clean up
sudo apt-get install -y bat > /dev/null

# install grc (general colourizer)
sudo apt-get install -y grc > /dev/null

# install vs code
sudo apt-get install -y apt-transport-https > /dev/null
curl -s -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm packages.microsoft.gpg
sudo apt-get update > /dev/null
sudo apt-get install -y code > /dev/null



### UX - Panel
echo "[*] Customizing top panel..."

# cache newest plugin ID
last_id=$(xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids| grep -v "Value is an\|^$" | sort -n | tail -1)

# remove existing launchers
rm -r ~/.config/xfce4/panel/launcher-*
xfconf-query -c xfce4-panel -p /plugins/plugin-4 -rR
xfconf-query -c xfce4-panel -p /plugins/plugin-5 -rR
xfconf-query -c xfce4-panel -p /plugins/plugin-6 -rR
xfconf-query -c xfce4-panel -p /plugins/plugin-7 -rR
xfce4-panel --restart

# create directory menu
xfconf-query -c xfce4-panel -p /plugins/plugin-4 -t string -s "directorymenu" --create
xfconf-query -c xfce4-panel -p /plugins/plugin-4/icon-name -t string -s "system-file-manager" -a --create
xfconf-query -c xfce4-panel -p /plugins/plugin-4/base-directory -t string -s "$HOME" -a --create
sleep 1

# create launcher (terminal)
xfce4-panel --add=launcher /usr/share/applications/terminator.desktop
sleep 1

# create launcher (firefox)
xfce4-panel --add=launcher /usr/share/applications/firefox-esr.desktop
sleep 1

# create launcher (burp)
xfce4-panel --add=launcher /usr/share/applications/kali-burpsuite.desktop
sleep 1

# apply panel changes
for i in $(seq 1 $last_id); do all_ids="$all_ids -t int -s $i"; done
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -rR
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids $(echo $all_ids) --create
xfce4-panel --restart



### Done
echo ""
echo "[*] ono-sendai env installed, use terminator and go hack stuff x_x"

