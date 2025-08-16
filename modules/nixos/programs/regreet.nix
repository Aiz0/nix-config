{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.programs.regreet.enable = lib.mkOption {
    description = "Enable regreet Display Manager, uses niri-unstable";
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.myNixOS.programs.regreet.enable {
    programs.regreet = {
      enable = true;
      theme.name = "Adwaita-dark";
      settings = {
        background = {
          # TODO: move to separate configuration
          path = builtins.path {path = ../../../assets/frieren.jpg;};
          fit = "Cover";
        };
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
