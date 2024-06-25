{
  programs.bash.enable = true;
  # TODO: This is not really the correct place for this (dotfile manager)
  programs.bash.initExtra = ''
  remarkable_stream() {
    firefox "https://''$1:2001/?portrait=true" &
    ssh root@''$1 "pgrep goMarkableStream | xargs kill; RK_SERVER_USERNAME=david RK_SERVER_PASSWORD=david ./goMarkableStream"
  }
'';
  programs.bash.shellAliases = {
    # TODO: git add && commit before?
    # TODO: relative path in repo?
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
    fix-zenzone = "systemctl restart bluetooth; sleep 2; bluetoothctl connect AC:BF:71:82:B2:ED";
    teams = "chromium https://teams.microsoft.com/v2/";
    ff_privat = "firefox -P David";
    ff_cudos = "firefox -P cudos";
  };
}
