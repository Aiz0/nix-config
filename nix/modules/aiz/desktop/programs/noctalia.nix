_: {
  flake.homeModules.aizDesktop = {
    self,
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.inputs.noctalia.homeModules.default
    ];

    home.packages = [self.inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default pkgs.gpu-screen-recorder];

    programs.noctalia = {
      enable = true;
      settings = {
        plugins = {
          enabled = ["noctalia/world_clock" "noctalia/screen_recorder"];
          auto_update = "all";
        };

        bar.default = {
          position = "left";
          margin_ends = 0;
          radius_top_left = 0;
          radius_bottom_left = 0;

          capsule = true;
          start = [
            "control-center"
            "sysmon"
            "noctalia/screen_recorder:recorder"
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
            "noctalia/world_clock:bar"
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
          avatar_path = config.myHome.avatar.path;
          clipboard_enabled = false; # I use vicinae
        };
        location.address = "Stockholm, Sweden";

        audio.enable_overdrive = false;

        # theme
        theme.builtin = "Catppuccin";
        wallpaper = {
          monitors = builtins.listToAttrs (map (monitor: {
              name = monitor.plug;
              value = {
                enabled = true;
                path = monitor.wallpaper.path;
              };
            })
            config.myHome.monitors);
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

        #lockscreen
        lockscreen_widgets = let
          primaryMonitors = lib.filter (m: m.primary) config.myHome.monitors;
          otherMonitors = lib.filter (m: !m.primary) config.myHome.monitors;
        in {
          enabled = true;
          widget =
            builtins.listToAttrs (lib.concatMap (monitor: [
                {
                  name = "clock@${monitor.plug}";
                  value = {
                    type = "clock";
                    output = monitor.plug;
                    cx = monitor.width * 1.0 / 2;
                    cy = 120.0;
                    box_width = 360.0;
                    box_height = 120.0;
                    settings = {
                      format = "{:%H:%M}";
                      background = false;
                      shadow = false;
                    };
                  };
                }
                {
                  name = "lockscreen-login-box@${monitor.plug}";
                  value = {
                    type = "login_box";
                    output = monitor.plug;
                    cx = monitor.width * 1.0 / 2;
                    cy = monitor.height * 1.0 - 182.0; # or wherever you want it
                    box_width = 810.0;
                    box_height = 196.0;
                    settings = {
                      show_media = false;
                      show_weather = true;
                    };
                  };
                }
              ])
              primaryMonitors)
            # Hide login box on other monitors
            // builtins.listToAttrs (map (monitor: {
                name = "lockscreen-login-box@${monitor.plug}";
                value = {
                  type = "login_box";
                  output = monitor.plug;
                  enabled = false;
                };
              })
              otherMonitors);
        };
      };
    };
  };
}
