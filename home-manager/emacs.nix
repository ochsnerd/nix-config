# see https://github.com/bbigras/nix-config/blob/731ddebeeef5043d98efc7994860aac9b22a8d5d/users/bbigras/dev/emacs.nix 
{ pkgs }:
{
  programs.emacs = {
    enable = true;
    package = (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git;
      config = ./emacs/config.org;
      alwaysEnsure = false;
      extraEmacsPackages = epkgs: [
        epkgs.vterm
        epkgs.use-package
        epkgs.copilot
      ];
    });
  };

  home.file = {
    ".config/emacs" = {
      source = ./emacs;
      recursive = true;
    };
  };
  # emacs daemon
  # services.emacs.package = pkgs.emacs-unstable;
}
