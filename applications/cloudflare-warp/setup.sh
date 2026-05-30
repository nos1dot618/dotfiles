#!/usr/env/bin bash
set -eu
source "$DOTFILES_ROOT/commons/utils.sh"

function setup_cloudflare_warp() {
    warp-cli registration new -- --accept-tos
}

if ! dpkg -s cloudflare-warp >/dev/null 2>&1; then
    # Reference: <https://pkg.cloudflareclient.com/>.
    install_package curl
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |
        sudo gpg --yes --dearmor \
            --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    # Add this repository to the apt-repositories.
    if grep -qiE '^(ID|ID_LIKE)=.*ubuntu' /etc/os-release; then
        # For Ubuntu/Ubuntu based distributions.
        echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
            https://pkg.cloudflareclient.com/ noble main" | \
            sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    else
        echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] \
            https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | \
            sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    fi
    log_note "Added Cloudflare-Warp to apt repositories."
    update_package_list
    install_package cloudflare-warp
    setup_cloudflare_warp
fi
