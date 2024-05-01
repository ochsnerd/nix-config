{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv
  ];

  programs.bash.interactiveShellInit = ''eval "$(direnv hook bash)"'';
}
