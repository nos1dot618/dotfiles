#!/usr/env/bin bash
set -xeu

function setup_cloudflare_warp() {
    warp-cli registration new
}

if ! dpkg -s cloudflare-warp >/dev/null 2>&1; then
    # Reference: <https://pkg.cloudflareclient.com/>
    sudo apt-get update && sudo apt-get install curl
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |
        sudo gpg --yes --dearmor \
            --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    # Add this repository to the apt-repositories
    echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" |
        sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    # Install
    sudo apt-get update && sudo apt-get install cloudflare-warp
    setup_cloudflare_warp
fi
