_: {
  flake.nixosModules.miyabi = {config, ...}: {
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
}
