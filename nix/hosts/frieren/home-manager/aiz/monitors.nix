_: {
  flake.homeModules.aizFrieren = {
    myHome.monitors = [
      {
        name = {
          manufacturer = "BOE";
          model = "0x0BCA";
          serial = "Unknown";
        };
        plug = "eDP-1";
        primary = true;
        width = 2256;
        height = 1504;
        wallpaper.path = builtins.path {path = ./assets/wallpaper.jxl;};
      }
    ];
  };
}
