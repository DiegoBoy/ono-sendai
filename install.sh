#!/bin/bash
# ono-sendai installer

echo "
##################
#   ono-sendai   #
##################
"

### Init
echo "[*] Init install..."
# update repos first
sudo apt-get update > /dev/null

# get base dir of this installer
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


### Dev mode
# enable dev if installer is in repo dir
if [[ $(git --git-dir "${SCRIPT_DIR}/.git" rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    # add env var to ~/.zshenv because its loaded before ~/.zshrc
    echo "export ONOSENDAI_DEV_PATH='${SCRIPT_DIR}'" >> ~/.zshenv
    echo "[*] Dev mode enabled (git)"
fi


### functions
# wrapper for oh-my-zsh to install it both as current $USER and root (required to run aliases and functions as root)
config_omz() {
    # install oh-my-zsh
    echo 'exit' | sh -c "$(curl -s -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null
    
    # install plugins
    git clone -q https://github.com/DiegoBoy/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone -q https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    
    # install theme powerlevel10k
    git clone -q https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

    # update configs for zsh + powerlevel10k
    if [[ -n "${ONOSENDAI_DEV_PATH}" ]]; then
        cp "${SCRIPT_DIR}/.p10k.zsh" ~/.p10k.zsh
        cp "${SCRIPT_DIR}/.zshrc" ~/.zshrc
    else
        wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/.p10k.zsh -O ~/.p10k.zsh
        wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/.zshrc -O ~/.zshrc
    fi

    # switch default shell to zsh
    chsh -s $(which zsh)
}



### Terminal
echo "[*] Installing terminal..."

# install terminator
sudo apt-get install -y terminator > /dev/null
mkdir -p ~/.config/terminator/
wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/terminator.config -O ~/.config/terminator/config
echo "TerminalEmulator=terminator" > ~/.config/xfce4/helpers.rc



### Shell
echo "[*] Installing shell..."

# install zsh, fonts and icons
sudo apt-get install -y zsh fonts-powerline > /dev/null

# install font optimized for powerlevel10k
sudo mkdir -p /usr/share/fonts/MesloNF/
sudo wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O /usr/share/fonts/MesloNF/MesloLGS_NF_Regular.ttf
sudo wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O /usr/share/fonts/MesloNF/MesloLGS_NF_Italic.ttf
sudo wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O /usr/share/fonts/MesloNF/MesloLGS_NF_Bold.ttf
sudo wget -q https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O /usr/share/fonts/MesloNF/MesloLGS_NF_Bold_Italic.ttf
sudo fc-cache -f

# config oh-my-zsh and plugins (also for root)
config_omz
sudo su -c "$(declare -f config_omz); config_omz" 
sudo apt-get install -y fzf > /dev/null



### Utilities
echo "[*] Installing utilities..."

# install bat (cat replacement with syntax-highlighting) and clean up
sudo apt-get install -y bat > /dev/null

# install grc (general colourizer)
sudo apt-get install -y grc > /dev/null
sudo curl -s -fsSL https://raw.githubusercontent.com/garabik/grc/master/grc.zsh -o /etc/grc.zsh

# install fd (find replacement)
sudo apt-get install -y fd-find

# install vs code
sudo apt-get install -y apt-transport-https > /dev/null
curl -s -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm packages.microsoft.gpg
sudo apt-get update > /dev/null
sudo apt-get install -y code > /dev/null

# install xclip (terminal to clipboard)
sudo apt-get install -y xclip

# open directory links (file:///home/user/) in file browser instead of vscode
xdg-mime default Thunar.desktop inode/directory

# reconfig wireshark to run as non-root
sudo apt-get install debconf-utils -y
sudo debconf-set-selections <<< 'wireshark-common wireshark-common/install-setuid boolean true'
sudo dpkg-reconfigure wireshark-common -fnoninteractive
sudo usermod -aG wireshark $USER
mkdir -p ~/.local/share/applications
sed 's/pkexec //g' /usr/share/applications/wireshark.desktop > ~/.local/share/applications/wireshark.desktop

## RDP
# install and enable rdp
sudo apt-get install xrdp dbus-x11 -y
sudo systemctl enable xrdp
sudo systemctl start xrdp

# fix black screen after login when reconnecting
sudo wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/startwm.sh -O /etc/xrdp/startwm.sh



### UX
echo "[*] Customizing UX..."

## Panel

# TODO
# prev conf: https://github.com/DiegoBoy/ono-sendai/commit/4423433d29b445975f56d3e440e4703e40890050#
# might be needed to fix Terminator plugin - launcher missing in panel, plugin-5 dissapears, might require adding launcher
# xfce4-panel --add=launcher /usr/share/applications/terminator.desktop

# cache newest plugin ID
last_id=$(xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids| grep -v "Value is an\|^$" | sort -n | tail -1)

# load profile
if [[ -n "${ONOSENDAI_DEV_PATH}" ]]; then
    xfce4-panel-profiles load "${SCRIPT_DIR}/xfce4-panel.xml"
else
    TMP_FILE="$(mktemp)"
    wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/xfce4-panel.xml -O "${TMP_FILE}"
    xfce4-panel-profiles load "${TMP_FILE}"
    rm -f "${TMP_FILE}"
fi

## Wallpaper
# copy readable image
sudo mkdir -p /usr/share/backgrounds/ono-sendai
sudo wget -q https://github.com/DiegoBoy/ono-sendai/raw/master/wallpaper.jpg -O /usr/share/backgrounds/ono-sendai/wallpaper.jpg
sudo chmod 0666 /usr/share/backgrounds/ono-sendai/wallpaper.jpg

# set wallpaper
deskpaths=$(xfconf-query -c xfce4-desktop -l | grep -i 'last-image$')
for d in $(echo $deskpaths); do xfconf-query -c xfce4-desktop -p $d -s /usr/share/backgrounds/ono-sendai/wallpaper.jpg > /dev/null; done



### Done
echo ""
echo "[*] ono-sendai env installed, use terminator and go hack stuff x_x"

