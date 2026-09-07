_: {
  flake.nixosModules.sakurasou = {
    services.displayManager.noctalia-greeter.settings = {
      appearance.wallpaper.path = builtins.path {path = ./assets/wallpaper-greeter.png;};
      output.name = "DP-2";
    };
  };
}
