{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ghc ];
}
