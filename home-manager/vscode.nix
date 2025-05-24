{ pkgs }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    # package = pkgs.vscodium;  <--- sadly c# extensions are anemic
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
    ];
  };
}
