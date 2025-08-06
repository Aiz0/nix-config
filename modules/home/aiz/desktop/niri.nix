{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHome.aiz.desktop.niri = {
    enable = lib.mkEnableOption "niri desktop environment";
    xwayland.enable = lib.mkOption {
      description = "Enable xwayland support";
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.myHome.aiz.desktop.niri.enable {
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.settings = {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
      input = {
        keyboard = {
          repeat-delay = 275;
          repeat-rate = 40;
          # Remove next release
          xkb = {
            layout = "us";
            #variant = "colemak_dh";
          };
        };
        touchpad = {
          tap = false;
          dwt = true; # disable while typing
          natural-scroll = true;
          scroll-factor = 0.3;
          click-method = "clickfinger";
        };
      };

      binds = with config.lib.niri.actions; {
        "MOD+Return".action = spawn "ghostty";
        "MOD+Space".action = spawn "fuzzel";
      };
    };
  };
}
