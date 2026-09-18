{ pkgs, ... }:
{
  # worth having a look at: https://rzetterberg.github.io/yubikey-gpg-nixos.html

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-gtk2;
  };

  programs.gpg.enable = true;

  # prevent gnome-keyring from handling ssh
  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
    ];
  };
}
