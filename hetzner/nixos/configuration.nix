{
  inputs,
  outputs,
  modulesPath,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      trusted-users = [
        "root"
        "david"
      ];
      experimental-features = "nix-command flakes";
      flake-registry = "";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
    channel.enable = false;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "hetzner";

  users.users.david = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGy9ZdCyw3Pwd5snef5C0U2izIjEfYrKxQUBHODaPigO laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0+kwufEnqBpSbOFKApFtopfMuJEXdtN0PywDpttzRH phone"
    ];
    extraGroups = [ "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    backupFileExtension = "backup";
    users.david = import ../home-manager/home.nix;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
