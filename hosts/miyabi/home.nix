{self, ...}: {
  home-manager.users.aiz = {
    imports = [self.homeConfigurations.aiz];
    config.myHome.hardware.monitors = [
      {
        name = {
          manufacturer = "AU optronics";
          model = "0x21ED";
          serial = "Unknown";
        };
        plug = "eDP-1";
        primary = true;
        width = 1920;
        height = 1080;
        wallpaper.path = builtins.path {path = ./assets/wallpaper.jxl;};
      }
    ];
  };
}
