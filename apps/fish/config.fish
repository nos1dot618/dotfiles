if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cls clear
alias gti git # For typos ;)

set -gx PATH \
    $HOME/ThirdParty/fasm \
    $PATH

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
