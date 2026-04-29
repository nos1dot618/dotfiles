if status is-interactive
    # Commands to run in interactive sessions can go here.
end

# Add aliases to a common file.
alias cls clear
alias gti git # For typos ;)

for path in (cat $HOME/.config/path.txt)
    set expanded (eval echo $path)
    fish_add_path $expanded
end

# Evaluate environment variables defined inside .envrc.
direnv hook fish | source
direnv allow

function vpn-on
    set current_mode (
    warp-cli settings 2>/dev/null \
        | string match -r '^Mode:.*' \
        | string replace 'Mode: ' ''
    )
    if test "$current_mode" != "warp+doh"
        warp-cli mode warp+doh >/dev/null
    end
    warp-cli connect
    curl -s "https://cloudflare.com/cdn-cgi/trace"
end

function vpn-off
    warp-cli disconnect
    curl -s "https://cloudflare.com/cdn-cgi/trace"
end

function git-push
    for remote in (git remote)
        log_info "Pushing to remote \"$remote\"."
        git push $remote $argv
    end
end

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1];
or set GHCUP_INSTALL_BASE_PREFIX $HOME;
