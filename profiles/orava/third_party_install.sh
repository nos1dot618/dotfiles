#!/usr/bin/env bash
set -xeu

mkdir -p "$MY_HOME/ThirdParty/debs"
sudo chown -R "$MY_USER" "$MY_HOME/ThirdParty"
cd "$MY_HOME/ThirdParty/debs"

while IFS= read -r url; do
    wget -nc -q "$url"
done < "$DOTFILES_ROOT/profiles/orava/third_party.list"

sudo apt-get -y install ./*.deb
