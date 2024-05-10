# My nixos config

## Setup

1. Get this repo somewhere on a nixos machine
2. Add `git` to `/etc/nixos/configuration.nix`, `sudo nixos-rebuild switch`
3. Copy hardware configuration from `/etc/nixos/hardware-configuration.nix` into `nixos`
4. `git config user.email "davidochsner93@gmail.com" && git add nixos/hardware-configuration.nix && git commit -m"New hardware config"`.
5. `export NIX_CONFIG="experimental-features = nix-command flakes" && nix flake update && sudo nixos-rebuild switch --flake <path to repo-root>`  <- maybe `--flake .#<hostname>`?
6. (update command in home-manager/bash.nix)
