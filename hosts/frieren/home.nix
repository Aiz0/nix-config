{self, ...}: {
  home-manager.users.aiz = {
    imports = [self.homeConfigurations.aiz];
    config.myHome.hardware.monitors = [
      {
        name = {
          manufacturer = "Unknown";
          model = "Unknown";
          serial = "Unknown";
        };
        plug = "eDP-1";
        primary = true;
        width = 2256;
        height = 1506;
        wallpaper.path = builtins.path {path = ./assets/wallpaper.jxl;};
      }
    ];
  };
}
