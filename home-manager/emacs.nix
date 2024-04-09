# see https://github.com/bbigras/nix-config/blob/731ddebeeef5043d98efc7994860aac9b22a8d5d/users/bbigras/dev/emacs.nix 
{ config, pkgs }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  home.file = {
    ".emacs.el" = {
      # TODO: Relative path of repo?
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/home-manager/emacs.el";
    };
  };
}
