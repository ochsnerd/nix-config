# see https://nixos.org/manual/nixpkgs/stable/#reference
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python312.withPackages(ps: with ps; [
      black
      pygments # syntax highlighting for orgmode latex export
    ]))
    pkgs.nodePackages.pyright
  ];
}
