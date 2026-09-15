# see https://github.com/bbigras/nix-config/blob/731ddebeeef5043d98efc7994860aac9b22a8d5d/users/bbigras/dev/emacs.nix
{ pkgs }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs;
      config = ./emacs.org;
      defaultInitFile = true;
      alwaysEnsure = true;
      extraEmacsPackages = epkgs: [
        epkgs.vterm
        epkgs.use-package
        epkgs.tree-sitter-langs
        (epkgs.treesit-grammars.with-grammars (gs: [
          gs.tree-sitter-rust
          gs.tree-sitter-typescript
          gs.tree-sitter-tsx
          gs.tree-sitter-python
          gs.tree-sitter-dockerfile
          gs.tree-sitter-yaml
          gs.tree-sitter-html
          gs.tree-sitter-bash
        ]))
      ];
    };
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
    socketActivation.enable = true;
    client.enable = true;
  };
}
