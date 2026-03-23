#!/usr/env/bin bash
set -eu
source "$DOTFILES_ROOT/applications/bash/commons.sh"

function setup_cloudflare_warp() {
    warp-cli registration new
}

if ! dpkg -s cloudflare-warp >/dev/null 2>&1; then
    # Reference: <https://pkg.cloudflareclient.com/>.
		install_package curl
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |
        sudo gpg --yes --dearmor \
             --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    # Add this repository to the apt-repositories.
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/cloudflare-client.list
		log_note "Added Cloudflare-Warp to apt repositories."
    # Install.
    install_package cloudflare-warp
    setup_cloudflare_warp
fi

log_info "Set up Cloudflare-Warp successfully."
