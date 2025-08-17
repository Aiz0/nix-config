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
    # TODO don't repeat thes here somehow.
    # Instead use niri flake options somehow
    outputs = let
      inherit (lib) mkOption types;
    in
      mkOption {
        type = types.listOf (types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              example = "DP-1";
            };
            width = mkOption {
              type = types.int;
              example = 1920;
            };
            height = mkOption {
              type = types.int;
              example = 1080;
            };
            refresh = {
              rate = mkOption {
                type = types.nullOr types.float;
                default = null;
              };
              variable = {
                enabled = lib.mkEnableOption "Enable variable refresh rate for this monitor";
                on-demand = lib.mkEnableOption "Only enable variable refresh rate when a window supports it";
              };
            };
            x = mkOption {
              type = types.int;
              default = 0;
            };
            y = mkOption {
              type = types.int;
              default = 0;
            };
            enabled = mkOption {
              type = types.bool;
              default = true;
            };
            primary = mkOption {
              type = types.bool;
              default = false;
            };
          };
        });
        default = [];
      };
  };

  config = lib.mkIf config.myHome.aiz.desktop.niri.enable {
    services.swayosd.enable = true;

    programs.niri.package = pkgs.niri-unstable;
    programs.niri.settings = {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
      outputs = builtins.listToAttrs (map (v: {
          name = v.name;
          value = {
            enable = v.enabled;
            mode.height = v.height;
            mode.width = v.width;
            mode.refresh = v.refresh.rate;
            variable-refresh-rate =
              if v.refresh.variable.enabled == true
              then
                if v.refresh.variable.on-demand == "true"
                then "on-demand"
                else true
              else false;
            position.x = v.x;
            position.y = v.y;
            focus-at-startup = v.primary;
          };
        })
        config.myHome.aiz.desktop.niri.outputs);

      input = {
        keyboard = {
          repeat-delay = 275;
          repeat-rate = 40;
        };
        touchpad = {
          tap = false;
          dwt = true; # disable while typing
          natural-scroll = true;
          scroll-factor = 0.3;
          click-method = "clickfinger";
        };
      };
      layout = {
        gaps = 8;
        focus-ring = {
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
        shadow.enable = true;
        struts = {
          left = 4;
          right = 4;
          top = 4;
          bottom = 4;
        };

        default-column-width = {proportion = 1. / 2.;};
        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];
      };
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;

      binds = with config.lib.niri.actions; {
        "MOD+Return".action = spawn config.myHome.profiles.defaultApps.terminal.exec;
        "MOD+Space".action = spawn "fuzzel";
        "MOD+P".action = spawn config.myHome.profiles.defaultApps.webBrowser.exec;
        "MOD+Z".action = spawn config.myHome.profiles.defaultApps.editor.exec;
        "MOD+Escape".action = spawn "loginctl" "lock-session";

        # Media / System Keys
        XF86AudioRaiseVolume.action = spawn "swayosd-client" "--output-volume" "raise";
        XF86AudioLowerVolume.action = spawn "swayosd-client" "--output-volume" "lower";
        XF86AudioMute.action = spawn "swayosd-client" "--output-volume" "mute-toggle";
        XF86AudioMicMute.action = spawn "swayosd-client" "--input-volume" "mute-toggle";
        XF86MonBrightnessUp.action = spawn "swayosd-client" "--brightness" "raise";
        XF86MonBrightnessDown.action = spawn "swayosd-client" "--brightness" "lower";

        # Niri actions

        "Mod+W".action = close-window;

        "Mod+M".action = focus-column-left;
        "Mod+N".action = focus-window-down;
        "Mod+E".action = focus-window-up;
        "Mod+I".action = focus-column-right;

        "Mod+Shift+M".action = move-column-left;
        "Mod+Shift+N".action = move-window-down;
        "Mod+Shift+E".action = move-window-up;
        "Mod+Shift+I".action = move-column-right;

        "Mod+Tab".action = focus-window-down-or-column-right;
        "Mod+Shift+Tab".action = focus-window-up-or-column-left;

        "Mod+Ctrl+M".action = focus-monitor-left;
        "Mod+Ctrl+N".action = focus-monitor-down;
        "Mod+Ctrl+E".action = focus-monitor-up;
        "Mod+Ctrl+I".action = focus-monitor-right;

        "Mod+Shift+Ctrl+M".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+N".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+E".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+I".action = move-column-to-monitor-right;

        "Mod+Shift+Ctrl+Alt+M".action = move-workspace-to-monitor-left;
        "Mod+Shift+Ctrl+Alt+N".action = move-workspace-to-monitor-down;
        "Mod+Shift+Ctrl+Alt+E".action = move-workspace-to-monitor-up;
        "Mod+Shift+Ctrl+Alt+I".action = move-workspace-to-monitor-right;

        "Mod+l".action = focus-workspace-down;
        "Mod+U".action = focus-workspace-up;

        "Mod+Page_Down".action = move-column-to-workspace-down;
        "Mod+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-to-workspace-down;
        "Mod+Ctrl+U".action = move-column-to-workspace-up;

        "Mod+Alt+Page_Down".action = move-workspace-down;
        "Mod+Alt+Page_Up".action = move-workspace-up;
        "Mod+Alt+L".action = move-workspace-down;
        "Mod+Alt+U".action = move-workspace-up;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Mod+Left".action = set-column-width "-10%";
        "Mod+Right".action = set-column-width "+10%";

        "Mod+Up".action = set-window-height "-10%";
        "Mod+Down".action = set-window-height "+10%";

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Mod+Alt+Escape".action = toggle-keyboard-shortcuts-inhibit;

        "Mod+D".action = screenshot-window;
        "MOD+Shift+D".action.screenshot-screen = [];
        "MOD+Ctrl+D".action = screenshot;

        "Mod+Shift+Q".action = quit;
      };
    };
  };
}
