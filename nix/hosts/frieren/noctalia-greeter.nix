_: {
  flake.nixosModules.frieren = {
    services.displayManager.noctalia-greeter.settings.appearance.wallpaper.path = builtins.path {path = ./assets/wallpaper-greeter.jpg;};
  };
}
