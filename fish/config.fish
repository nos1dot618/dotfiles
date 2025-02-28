if status is-interactive
    # Commands to run in interactive sessions can go here
end
abbr -a -- enw 'emacs -nw'
abbr -a -- later 'ls -latr'

set -U HOME "/home/nosferatu"

# PATH
set -U fish_user_paths \
	$HOME/ThirdParty/zig-linux-x86_64-0.14.0 \
	$HOME/ThirdParty/odin-linux-amd64-dev-2025-02 \
	$HOME/ThirdParty/ols \
	$HOME/.cargo/env
