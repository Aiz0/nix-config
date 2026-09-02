_: {
  flake.nixosModules.frieren = {
    flake.desktop.regreet.background.path = builtins.path {path = ./assets/wallpaper-greeter.jpg;};
  };
}
