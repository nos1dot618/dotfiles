#!/usr/bin/env bash
set -xeu

mkdir "$MY_HOME/.config/autostart/"

cat > "$MY_HOME/.config/autostart/kde_startup_script.sh" <<EOF
[Desktop Entry]
Exec=$DOTFILES_ROOT/scripts/kde_startup_script.sh
Icon=dialog-scripts
Name=kde_startup_script.sh
Path=
Type=Application
X-KDE-AutostartScript=true
EOF
