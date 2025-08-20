{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHome.services.hypridle = {
    enable = lib.mkEnableOption "hypridle idle/lock manager";

    autoSuspend = lib.mkOption {
      description = "Whether to autosuspend on idle.";
      default = true;
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.myHome.services.hypridle.enable {
    home.packages = [
      pkgs.wlopm # wayland output power management
    ];
    myHome.programs.hyprlock.enable = true; # enable lock application
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "pidof hyprlock || hyprlock --no-fade-in --immediate";
          after_sleep_cmd = "wlopm --on *";
        };
        listener =
          [
            {
              # lower screen brightness
              timeout = 60;
              on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
              on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
            }
            {
              # lock after 5 min
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              # screen off after 6 min
              timeout = 360;
              on-timeout = "wlopm --off *";
              on-resume = "wlopm --on *";
            }
          ]
          ++ lib.optional config.myHome.services.hypridle.autoSuspend {
            # suspend after 10 min
            timeout = 600;
            on-timeout = "systemctl suspend";
          };
      };
    };
  };
}
