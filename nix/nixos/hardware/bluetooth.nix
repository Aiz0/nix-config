_: {
  flake.nixosModules.default = {pkgs, ...}: {
    hardware.
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez-experimental;
    };
  };
}
