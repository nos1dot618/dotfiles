#!/usr/bin/env bash
set -xeu

: "${MY_HOME:?ERROR: MY_HOME environment-variable is not set.}"
: "${MY_USER:?ERROR: MY_USER environment-variable is not set.}"
: "${DOTFILES_ROOT:?ERROR: DOTFILES_ROOT environment-variable is not set.}"

BASE_DIR="$MY_HOME/Thirdparty"
PACKAGE_DIR="$BASE_DIR/.packages"
INSTALLED_FILE="$BASE_DIR/.installed"
LIST_FILE="$DOTFILES_ROOT/profiles/orava/third_party.list"

mkdir -p "$PACKAGE_DIR"
touch "$INSTALLED_FILE"

sudo chown -R "$MY_USER:$MY_USER" "$BASE_DIR"
cd "$PACKAGE_DIR"

new_packages=()

while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line//$'\r'/}" # Strip CR
  line="${line%%#*}"
  line="$(printf '%s' "$line" | xargs)"
  [[ -z "$line" ]] && continue
  package="$(basename "$line")"
  if grep -Fxq "$package" "$INSTALLED_FILE"; then
    echo "INFO: Package '$package' already installed; skipping installation."
    continue
  fi
  echo "INFO: Downloading '$line'."
  if [[ -f "$package" ]]; then
    echo "INFO: Package '$package' already downloaded; skipping download."
    new_packages+=("$package")
    continue
  fi
  wget -nc "$line"
  [[ -f "$package" ]] && new_packages+=("$package")
done <"$LIST_FILE"

if ((${#new_packages[@]} > 0)); then
  sudo apt-get -y install "./${new_packages[@]}"
  for package in "${new_packages[@]}"; do
    echo "$package" >>"$INSTALLED_FILE"
    rm -f "$package"
  done
else
  echo "WARN: No new packages to install."
fi
