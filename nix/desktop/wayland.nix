_: {
  flake.nixosModules.desktop = {
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
