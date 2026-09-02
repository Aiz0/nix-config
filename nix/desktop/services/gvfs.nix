_: {
  flake.nixosModules.desktop = {
    services.gvfs.enable = true;
  };
}
