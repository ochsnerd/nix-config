{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
  };

  # do not set fish as the default shell (might break stuff)
  # instead, start fish from bash
  programs.bash.interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';

  environment.shellAliases = {
    teams = "chromium https://teams.microsoft.com/v2/";
    ff = "firefox -P David";
    ff-cudos = "firefox -P cudos";
  };

  environment.systemPackages = with pkgs; [
    ghostty
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.forgit
    fishPlugins.hydro
    fzf
    fishPlugins.grc
    grc
  ];

  # see the rest in home-manager/fish.nix
}
