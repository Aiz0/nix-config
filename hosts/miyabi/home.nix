{self, ...}: {
  home-manager.users.aiz = {
    imports = [self.homeConfigurations.aiz];
    config.myHome.hardware.monitors = [
      {
        plug = "eDP-1";
        primary = true;
        wallpaper.path = builtins.path {path = ./assets/wallpaper.jxl;};
      }
    ];
  };
}
