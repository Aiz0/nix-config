_: {
  flake.homeModules.aizDesktop = {
    self,
    pkgs,
    ...
  }: {
    imports = [
      self.inputs.noctalia.homeModules.default
    ];

    home.packages = [self.inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];

    programs.noctalia = {
      enable = true;
      settings = {
        bar.default = {
          position = "left";
          margin_ends = 0;
          radius_top_left = 0;
          radius_bottom_left = 0;

          capsule = true;
          start = [
            "control-center"
            "sysmon"
            "media"
            "tray"
          ];
          center = ["workspaces"];
          end = [
            "notifications"
            "network"
            "bluetooth"
            "battery"
            "volume"
            "brightness"
            "weather"
            "clock"
          ];
        };
        widget = {
          clock.vertical_format = "{:%H\n%M}\n-\n{:%a\n%d\n%b}";
          volume.show_label = false;
          tray = {
            drawer = true;
          };
          workspaces.show_labels = false;
        };

        osd.kinds = {
          media = false; # i find it annoying
          lock_keys = false; # if i idle then scroll lock turns off??? need to figure out root cause here
        };

        shell = {
          # TODO: fix avatar
          #avatar_path = config.myHome.profiles.avatar.path;
          clipboard_enabled = false; # I use vicinae
        };
        location.address = "Stockholm, Sweden";

        # theme
        theme.builtin = "Catppuccin";
        wallpaper = {
          # TODO: fix monitors
          # monitors = builtins.listToAttrs (map (monitor: {
          #     name = monitor.plug;
          #     value = {
          #       enabled = true;
          #       path = monitor.wallpaper.path;
          #     };
          #   })
          #   config.myHome.hardware.monitors);
        };
        backdrop.enabled = true;

        # Idle
        idle = {
          behavior_order = ["lower_brightness" "lock"];
          behavior = {
            lower_brightness = {
              timeout = 180;
              action = "command";
              command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
              resume_command = "${pkgs.brightnessctl}/bin/brightnessctl -r";
              enabled = false;
            };
            lock = {
              timeout = 300;
              action = "lock";
              enabled = true;
            };
          };
        };
      };
    };
  };
}
