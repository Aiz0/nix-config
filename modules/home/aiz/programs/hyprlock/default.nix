{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.programs.hyprlock.enable = lib.mkEnableOption "hyprlock lock screen";

  config = lib.mkIf config.myHome.aiz.programs.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          monitor = "";
          #TODO: add background
          path = "~/" + config.xdg.configFile.wallpaper.target;
          color = "rgba(25, 20, 20, 1.0)";

          blur_passes = 2; # 0 disables blurring
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };
        # TODO: show profile picture
        image = {
          monitor = "";
          path = "~/" + config.xdg.configFile.avatar.target;
          border_color = "0xffdddddd";
          border_size = 2;
          size = 100;
          rounding = -1;
          position = "0, 160";
          halign = "center";
          valign = "bottom";
        };
        label = [
          # Current date
          {
            monitor = "";
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
            monitor = "";
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
            monitor = "";
            # I prefer the capitalized version
            # TODO: add this as a config option
            # its used in other places
            text = "Aiz";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 12;
            font_family = "SF Pro Display Bold";
            position = "0, 125";
            halign = "center";
            valign = "bottom";
          }

          # Password label
          {
            monitor = "";
            text = "Enter Password";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 10;
            font_family = "SF Pro Display";
            position = "0, 100";
            halign = "center";
            valign = "bottom";
          }
        ];

        input-field = {
          monitor = "";
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
        };
      };
    };
  };
}
