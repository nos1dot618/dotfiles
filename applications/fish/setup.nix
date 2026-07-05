{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      y = "yazi";
    };
    shellInit = ''
      set -U fish_user_paths \
	        $HOME/.local/bin
    '';
  };
}
