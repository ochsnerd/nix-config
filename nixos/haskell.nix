{ pkgs, ... }:

let
  myHaskellEnv = pkgs.haskellPackages.ghcWithPackages (ghcPkgs: with ghcPkgs; [
    # random
  ]);
in
{
    environment.systemPackages = with pkgs; [
      myHaskellEnv
      haskell-language-server
  ];
}
