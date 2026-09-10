_: {
  flake.nixosModules.desktop = {
    services.udisks2.enable = true;
  };
}
