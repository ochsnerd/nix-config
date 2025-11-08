{ pkgs, ... }:
{
  environment.variables = {
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [ vim ];
}
