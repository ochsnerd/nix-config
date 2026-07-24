{ pkgs }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    # package = pkgs.vscodium;  <--- sadly c# extensions are anemic
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
      ];
      languageSnippets = {
        csharp = {
          "Wrap with Debug" = {
            body = [
              "Debug(\${TM_SELECTED_TEXT:$1})"
            ];
            description = "Wrap selected expression with Debug()";
            prefix = [
              "dbg"
            ];
          };
        };
      };
    };
  };
}
