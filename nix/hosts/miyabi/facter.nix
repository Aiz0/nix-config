_: {
  flake.nixosModules.miyabi = {self, ...}: {
    hardware.facter.reportPath = self + "/nix/hosts/miyabi/facter.json";
  };
}
