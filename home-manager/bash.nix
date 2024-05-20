{
  programs.bash.enable = true;
  programs.bash.shellAliases = {
    # TODO: git add && commit before?
    # TODO: relative path in repo?
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
    fix-zenzone = "systemctl restart bluetooth; sleep 2; bluetoothctl connect AC:BF:71:82:B2:ED";
  };
}
