# My nixos config

## Setup

1. Get this repo somewhere on a nixos machine
2. Copy hardware configuration from /etc/nixos/hardware-configuration.nix inot nixos.
3. `sudo nixos-rebuild switch --flake <path to repo-root>`
4. (update command in home-manager/bash.nix)