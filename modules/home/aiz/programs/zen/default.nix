{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  engines = import ./engines.nix;
in {
  imports = [
    self.inputs.zen-browser.homeModules.beta
  ];

  options.myHome.aiz.programs.zen.enable = lib.mkEnableOption "zen web browser";

  config = lib.mkIf config.myHome.aiz.programs.zen.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles = {
        default = {
          containersForce = true;

          containers = {
            personal = {
              color = "blue";
              icon = "circle";
              id = 1;
              name = "Default";
            };

            private = {
              color = "red";
              icon = "fingerprint";
              id = 2;
              name = "Private";
            };

            work = {
              color = "orange";
              icon = "briefcase";
              id = 3;
              name = "Work";
            };
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            augmented-steam
            proton-pass
            consent-o-matic
            ublock-origin
            web-scrobbler
            refined-github
            libredirect
            indie-wiki-buddy
            tampermonkey
            image-search-options
          ];

          id = 0;

          search = {
            inherit engines;
            default = "ddg";
            force = true;

            order = [
              "ddg"
              "Home Manager Options"
              "Kagi"
              "NixOS Wiki"
              "nixpkgs"
              "Noogle"
            ];
          };

          settings = {
            "zen.tabs.vertical.right-side" = true;
            "zen.welcome-screen.seen" = true;
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.experimental-no-window-controls" = true;
          };
        };
      };
    };
  };
}
