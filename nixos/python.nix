# see https://nixos.org/manual/nixpkgs/stable/#reference
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python311.withPackages(ps: with ps; [
      black
    ]))
    pkgs.nodePackages.pyright
  ];
}
