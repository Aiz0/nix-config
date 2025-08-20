# TODO: fix todos and move out of aiz modules folder
{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.programs.hyprlock = {
    enable = lib.mkEnableOption "hyprlock lock screen";
    displayName = lib.mkOption {
      description = "Display name on lock screen. defaults to username";
      default = config.home.username or "";
      type = lib.types.str;
    };
    avatar = {
      path = lib.mkOption {
        description = "Path to user avatar, if null shows nothing";
        default = config.myHome.profiles.avatar.path or null;
        type = lib.types.nullOr lib.types.path;
      };
    };
  };

  config = lib.mkIf config.myHome.aiz.programs.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = let
        primaryMonitors = lib.filter (m: m.primary) config.myHome.hardware.monitors;
      in {
        background =
          builtins.map (monitor: {
            monitor = monitor.plug;
            inherit (monitor.wallpaper) path;
            color = "rgba(25, 20, 20, 1.0)";

            blur_passes = 2; # 0 disables blurring
            blur_size = 7;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          })
          config.myHome.hardware.monitors;
        # User Avatar
        image = lib.mkIf (config.myHome.aiz.programs.hyprlock.avatar.path != null) (builtins.map (monitor: {
            monitor = monitor.plug;
            inherit (config.myHome.aiz.programs.hyprlock.avatar) path;
            border_color = "0xffdddddd";
            border_size = 2;
            size = 100;
            rounding = -1;
            position = "0, 160";
            halign = "center";
            valign = "bottom";
          })
          primaryMonitors);
        label = builtins.concatLists (builtins.map (monitor: [
            # Current date
            {
              monitor = monitor.plug;
              text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 20;
              font_family = "SF Pro Display Bold";
              position = "0, -100";
              halign = "center";
              valign = "top";
            }

            # Current time
            {
              monitor = monitor.plug;
              text = "$TIME";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 93;
              font_family = "SF Pro Display Bold";
              position = "0, -150";
              halign = "center";
              valign = "top";
            }
            # Show username
            {
              monitor = monitor.plug;
              text = config.myHome.aiz.programs.hyprlock.displayName;
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 12;
              font_family = "SF Pro Display Bold";
              position = "0, 125";
              halign = "center";
              valign = "bottom";
            }

            # Password label
            {
              monitor = monitor.plug;
              text = "Enter Password";
              color = "rgba(242, 243, 244, 0.75)";
              font_size = 10;
              font_family = "SF Pro Display";
              position = "0, 100";
              halign = "center";
              valign = "bottom";
            }
          ])
          primaryMonitors);

        input-field =
          builtins.map (monitor: {
            monitor = monitor.plug;
            size = "300, 30";
            outline_thickness = 0;
            dots_size = 0.25; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.55; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(242, 243, 244, 0)";
            inner_color = "rgba(242, 243, 244, 0)";
            font_color = "rgba(242, 243, 244, 0.75)";
            fade_on_empty = false;
            placeholder_text = "";
            position = "0, 60";
            halign = "center";
            valign = "bottom";
          })
          primaryMonitors;
      };
    };
  };
}
