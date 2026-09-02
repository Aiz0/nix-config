_: {
  flake.homeModules.aizDesktop = {
    config,
    pkgs,
    lib,
    ...
  }: {
    services = {
      gnome-keyring.enable = true;
    };

    # Don't know how much of this is necessary
    # but it works now
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = false;
      config = {
        common = {
          default = [
            "gtk"
            "gnome"
            "kde"
          ];
        };
        niri = {
          default = [
            "gtk"
            "gnome"
            "kde"
          ];
          "org.freedesktop.impl.portal.FileChooser" = "kde";
        };
      };
    };
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    programs.niri.package = pkgs.niri-unstable;
    programs.niri.settings = {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;

      # Generate niri output configuration from monitor module.
      outputs = builtins.listToAttrs (map (v: {
          name = "${v.name.manufacturer} ${v.name.model} ${v.name.serial}";
          value = {
            enable = v.enabled;
            mode.height = v.height;
            mode.width = v.width;
            mode.refresh = v.refreshRate.value;
            variable-refresh-rate =
              if v.refreshRate.variable.enabled && v.refreshRate.variable.on-demand
              then "on-demand"
              else v.refreshRate.variable.enabled;
            position.x = v.position.x;
            position.y = v.position.y;
            focus-at-startup = v.primary;
          };
        })
        config.myHome.monitors);

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
      prefer-no-csd = true;
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
      window-rules = [
        {
          geometry-corner-radius = let
            radius = 8.0;
          in {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
          clip-to-geometry = true;
        }
      ];
      layer-rules = [
        # Needed for noctalia wallpaper backdrop to work
        {
          matches = [{namespace = "^noctalia-backdrop";}];
          place-within-backdrop = true;
        }
      ];
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;
      screenshot-path = "${config.xdg.userDirs.pictures}/screenshots/niri %Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        {
          command = [
            "noctalia"
          ];
        }
      ];

      binds = with config.lib.niri.actions; {
        # TODO: FIX DEFAULT APPS
        # "MOD+Return".action = spawn config.myHome.profiles.defaultApps.terminal.exec;

        #Vicinae launcher
        "MOD+Space".action = spawn "vicinae" "toggle";
        # open window switcher
        "MOD+Shift+Space".action = spawn "vicinae" "vicinae://launch/wm/switch-windows";

        # TODO: FIX DEFAULT APPS
        # "MOD+P".action = spawn config.myHome.profiles.defaultApps.webBrowser.exec;
        # "MOD+Shift+P".action = spawn config.myHome.profiles.defaultApps.webBrowser.exec "--private-window";
        # "MOD+Z".action = spawn config.myHome.profiles.defaultApps.editor.exec;
        "MOD+Escape".action = spawn "loginctl" "lock-session";

        # Media / System Keys
        XF86AudioRaiseVolume.action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
        XF86AudioLowerVolume.action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
        XF86AudioMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        XF86AudioMicMute.action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        XF86MonBrightnessUp.action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "+5%";
        XF86MonBrightnessDown.action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-";

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
        "Mod+Shift+L".action = move-column-to-workspace-down;
        "Mod+Shift+U".action = move-column-to-workspace-up;

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

        "Mod+D".action.screenshot-window = [];
        "MOD+Shift+D".action.screenshot-screen = [];
        "MOD+Ctrl+D".action.screenshot = [];

        "Mod+Shift+Q".action = quit;
      };
    };
  };
}
