# originally from https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
{ config, pkgs, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs = {
    firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          # add policies here...

          /* ---- EXTENSIONS ---- */
          ExtensionSettings = {
            "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # add extensions here...
          };
  
          /* ---- PREFERENCES ---- */
          # Set preferences shared by all profiles.
          Preferences = { 
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            # add global preferences here...
          };
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles ={
        david = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0;               # 0 is the default profile; see also option "isDefault"
          name = "David";   # name as listed in about:profiles
          isDefault = true;     # can be omitted; true if profile ID is 0
          settings = {          # specify profile-specific preferences here; check about:config for options
            "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
            "browser.startup.homepage" = "https://duckduckgo.com";
            "browser.newtabpage.pinned" = [{
              title = "DuckDuckGo";
              url = "https://duckduckgo.com";
            }];
            # add preferences for profile_0 here...
          };
        };
        mf = {
          id = 1;
          name = "M&F";
          isDefault = false;
          settings = {
            "browser.newtabpage.activity-stream.feeds.section.highlights" = true;
            "browser.startup.homepage" = "https://mail.google.com";
            # add preferences for profile_1 here...
          };
        };
        man= {
          id = 2;
          name = "MAN";
          isDefault = false;
          settings = {
            "browser.newtabpage.activity-stream.feeds.section.highlights" = true;
            "browser.startup.homepage" = "https://mail.google.com";
            # add preferences for profile_1 here...
          };
        };
      # add profiles here...
      };
    };
  };
}
