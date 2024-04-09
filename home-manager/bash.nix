{
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    # TODO: git add && commit before?
    # TODO: relative path in repo?
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
  };
}
