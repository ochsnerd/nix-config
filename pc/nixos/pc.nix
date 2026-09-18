{
  config,
  lib,
  pkgs,
  ...
}:
{
  # see https://nixos.wiki/wiki/Nvidia
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    # pin to legacy channel to support Pascal (GTX 1070)
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  environment.systemPackages = [ pkgs.r2modman ];
}
