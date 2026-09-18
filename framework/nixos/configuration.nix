# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    ./vim.nix
    ./python.nix
    ./direnv.nix
    ./kanata.nix
    ./shell.nix
    ./nix.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      david = import ../home-manager/home.nix;
    };
    backupFileExtension = "backup";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.lofi.overlays.default
      (import inputs.emacs-overlay)

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    just
    jq
    graphviz
    htop

    spotify
    proton-vpn
    # deactivated because it uses unsafe electron version
    bitwarden-desktop
    dropbox

    libreoffice-qt6-fresh

    gnome-boxes

    gnomeExtensions.tophat

    dockerfile-language-server
    yaml-language-server

    pandoc
    mermaid-cli

    # from overlays
    lofi
  ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.steam.enable = true;

  programs.nix-index-database.comma.enable = true;

  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [
    "kvm-amd"
    "kvm-intel"
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    nerd-fonts.fira-code
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "david";
  # for CraneCam Pi
  networking.firewall.allowedTCPPorts = [
    5300
    4317
  ];

  time.timeZone = "Europe/Zurich";

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  security.rtkit.enable = true;
  # check https://nixos.wiki/wiki/PipeWire

  users.users = {
    david = {
      initialPassword = "";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0+kwufEnqBpSbOFKApFtopfMuJEXdtN0PywDpttzRH phone"
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
        "kvm"
      ];
    };
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";
}
