framework:
    sudo nixos-rebuild switch --flake .#framework

pc:
    sudo nixos-rebuild switch --flake .#pc

deploy_hetzner:
    nix run .#deploy

fmt:
    nix fmt

check:
    nix flake check