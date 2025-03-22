if status is-interactive
    # Commands to run in interactive sessions can go here
end
abbr -a -- enw 'emacs -nw'
abbr -a -- later 'ls -latr'

set -U HOME "/home/nosferatu"
set -x JAVA_HOME $HOME/ThirdParty/jdk-23.0.2

# PATH
set -U fish_user_paths \
	$HOME/ThirdParty/zig-linux-x86_64-0.14.0 \
	$HOME/ThirdParty/odin-linux-amd64-dev-2025-02 \
	$HOME/ThirdParty/ols \
	$HOME/ThirdParty/focus/focus \
	$HOME/.cargo/env \
	$HOME/ThirdParty/jdk-23.0.2/bin \
	$HOME/ThirdParty/gradle-8.13/bin
