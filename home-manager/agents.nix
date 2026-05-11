{ pkgs }:
{
  programs.opencode = {
    enable = true;
    package = pkgs.unstable.opencode;
    # TODO: As soon as home-manager exposes the tui, set scroll_speed here
    # https://home-manager-options.extranix.com/?query=opencode
    settings = {
      autoshare = false;
      autoupdate = false;
    };
  };

  # see also fish.nix cudos-claude
  programs.claude-code = {
    enable = true;
    package = pkgs.unstable.claude-code;
  };
}
