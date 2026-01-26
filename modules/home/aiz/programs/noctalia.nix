{
  config,
  lib,
  osConfig,
  pkgs,
  self,
  ...
}: {
  options.myHome.aiz.programs.noctalia.enable = lib.mkEnableOption "Noctalia desktop shell";

  imports = [
    self.inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf (config.myHome.aiz.programs.noctalia.enable && osConfig.myNixOS.services.noctalia.enable) {
    home.packages = [self.inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          position = "left";
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {id = "SystemMonitor";}
              {id = "MediaMini";}
              {id = "Tray";}
            ];
            center = [
              {
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right =
              [
                {id = "ScreenRecorder";}
                {id = "NotificationHistory";}
                {id = "WiFi";}
                {id = "Bluetooth";}
              ]
              ++ lib.optional osConfig.myHardware.profiles.laptop.enable {id = "Battery";}
              ++ [
                {id = "Volume";}
              ]
              ++ lib.optional osConfig.myHardware.profiles.laptop.enable {id = "Brightness";}
              ++ [
                {
                  id = "Clock";
                  formatVertical = "HH mm - ddd MMM d";
                }
              ];
          };
        };
        colorSchemes.predefinedScheme = "Catppuccin";
        general = {
          avatarImage = config.myHome.profiles.avatar.path;
          showScreenCorners = false;
        };

        location = {
          name = "Stockholm, Sweden";
          showWeekNumberInCalendar = true;
        };

        wallpaper.enabled = false;
        dock.enabled = false;

        notifications.location = "top_left";

        ui = {
          fontFixed = "monospace";
          panelBackgroundOpacity = 1.0;
        };
      };
    };
  };
}
