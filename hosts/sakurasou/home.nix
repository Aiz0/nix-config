{self, ...}: {
  home-manager.users.aiz = {
    imports = [self.homeConfigurations.aiz];
    config.myHome.hardware.monitors = [
      {
        name = {
          manufacturer = "LG Electronics";
          model = "LG ULTRAGEAR";
          serial = "102NTKFG9141";
        };
        plug = "DP-2";
        width = 2560;
        height = 1440;
        position.x = 0;
        position.y = 0;
        primary = true;
        refreshRate.variable.enabled = true;
        wallpaper.path = builtins.path {path = ./assets/wallpaper-mashiro.jxl;};
      }
      {
        name = {
          manufacturer = "PNP(BNQ)";
          model = "BenQ GW2470";
          serial = "V8F02974019";
        };
        plug = "HDMI-A-2";
        width = 1920;
        height = 1080;
        position.x = -1920;
        position.y = 0;
        wallpaper.path = builtins.path {path = ./assets/wallpaper-aiz.jxl;};
      }
    ];
  };
}
