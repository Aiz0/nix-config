{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.programs.regreet = {
    enable = lib.mkOption {
      description = "Enable regreet Display Manager, uses niri-unstable";
      default = false;
      type = lib.types.bool;
    };
    background = {
      path = lib.mkOption {
        description = "Background to use for regreet window";
        default = builtins.path {path = ../../../assets/frieren.jpg;};
        type = lib.types.path;
      };
      fit = lib.mkOption {
        description = "How the background image covers the screen if the aspect ratio doesn't match";
        default = "Cover";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.myNixOS.programs.regreet.enable {
    security.pam.services.gdm = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
      kwallet.enable = true;
    };

    services.displayManager.regreet = {
      enable = true;
      theme.name = "Adwaita-dark";
      settings = {
        skip_selection = true;
        inherit (config.myNixOS.programs.regreet) background;
      };
    };

    # TODO: move to services directory
    # TODO: setup output configuration and colors
    services.greetd = let
      niri-config = pkgs.writeText "niri-config" ''
        hotkey-overlay {
            skip-at-startup
        }
        environment {
            GTK_USE_PORTAL "0"
            GDK_DEBUG "no-portals"
        }

        // other settings

        // open regreet maximized
        window-rule {
            open-fullscreen true
        }

        // don't animate the window
        animations {
          off
        }

        gestures {
          hot-corners {
            off
          }
        }

        layout {
          background-color "#000000"
        }

        spawn-at-startup "sh" "-c" "${lib.getExe pkgs.regreet}; pkill -f niri"
      '';
    in {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.niri-unstable} -c ${niri-config}";
          user = "greeter";
        };
      };
    };
  };
}
