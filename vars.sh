export DOTFILES_ROOT=$(pwd)
export PROFILE="$DOTFILES_ROOT/profiles/orava-kde"
# NOTE: This is needed such that superuser scripts does not
#       assume the user 'root' and home '/root', when running
#       commands as superuser. Thus, this file should not be
#       run as root.
export MY_USER="$USER"
export MY_HOME="$HOME"
