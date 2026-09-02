_: {
  flake.nixosModules.sakurasou = {
    flake.desktop.regreet.background.path = builtins.path {path = ./assets/wallpaper-greeter.png;};
    services.displayManager.regreet.theme.name = "Adwaita";
  };
}
