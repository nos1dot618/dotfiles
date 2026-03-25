#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

mkdir -p "$MY_HOME/.config/autostart/"

chmod +x "$PROFILE/startup.sh"

cat > "$MY_HOME/.config/autostart/kde_startup_script.sh" <<EOF
[Desktop Entry]
Exec=$PROFILE/startup.sh
Icon=dialog-scripts
Name=kde_startup_script.sh
Path=
Type=Application
X-KDE-AutostartScript=true
EOF

