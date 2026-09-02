_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.flake.desktop.regreet = {
      background = {
        path = lib.mkOption {
          description = "Background to use for regreet window";
          default = null;
          type = lib.types.path;
        };
      };
    };

    config = {
      security.pam.services.gdm = {
        enableGnomeKeyring = true;
        gnupg.enable = true;
        kwallet.enable = true;
      };

      services.displayManager.regreet = {
        enable = true;
        theme.name = lib.mkDefault "Adwaita-dark";
        settings = {
          skip_selection = true;
          inherit (config.flake.desktop.regreet) background;
        };
      };

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
  };
}
