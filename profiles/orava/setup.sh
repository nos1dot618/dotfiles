#!/usr/bin/env bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

create_symlink "$DOTFILES_ROOT/profiles/orava/path.txt" "$MY_HOME/.config/path.txt"
create_symlink "$DOTFILES_ROOT/profiles/orava/.envrc" "$MY_HOME/.envrc"

update_package_list

HOSTNAME="orava"
sudo hostnamectl set-hostname "$HOSTNAME"
log_info "Hostname set to \"$HOSTNAME\"."

sudo -E bash "$DOTFILES_ROOT/profiles/orava/install.sh"

direnv allow ~
log_info "Set up environment variables management via \"direnv\"".

applications_file="$PROFILE/Applications.txt"
if [[ -f "$applications_file" ]]; then
    while IFS= read -r application || [[ -n "$application" ]]; do
        application="$(echo "$application" | xargs)"

        # Skip empty lines and comments
        [[ -z "$application" || "$application" == \#* ]] && continue

        bash "$DOTFILES_ROOT/applications/$application/setup.sh"
        log_info "Successfully installed application '$application'."
    done < "$applications_file"
fi

bash "$DOTFILES_ROOT/fonts/setup.sh"

log_info "Set up profile \"Orave\" successfully."
