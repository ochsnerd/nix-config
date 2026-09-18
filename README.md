# My nixos configs

Apply by the justfile

## Setup

(note that this might be done more elegantly with nix-anywhere or something)

1. `nix-shell -p git vim`
2. git clone this
3. Copy hardware configuration from `/etc/nixos/hardware-configuration.nix` into `nixos`, call it something
4. Add a new config to `flake.nix:nixosConfigurations`
5. `git commit` for flakes to pick up the new file
6. `export NIX_CONFIG="experimental-features = nix-command flakes" && nix flake update && sudo nixos-rebuild switch --flake <path to repo-root>#new-name`

## Docs

nixos options: https://search.nixos.org/options
home manager: https://home-manager-options.extranix.com/
