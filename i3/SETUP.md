Setting Dark theme for gtk applications
```bash
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
```
---

Install [copyq](https://github.com/hluk/CopyQ) clipboard manager
```bash
cd ~/Downloads
wget https://github.com/hluk/CopyQ/releases/download/v7.1.0/copyq_7.1.0_Debian_12-1_amd64.deb
sudo apt install ./copyq_7.1.0_Debian_12-1_amd64.deb
```
---

Disable auto suspend on laptop lid close
> Reference: <https://unix.stackexchange.com/a/52645>
Edit `/etc/systemd/logind.conf` and make sure you have:
```config
HandleLidSwitch=ignore
```
Reload `logind.conf` to make changes go into effect:
```bash
systemctl restart systemd-logind
```