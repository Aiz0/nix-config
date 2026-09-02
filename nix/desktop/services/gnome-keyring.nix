_: {
  flake.nixosModules.desktop = {
    services.gnome.gnome-keyring.enable = true;
  };
}
