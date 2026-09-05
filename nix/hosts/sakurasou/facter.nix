_: {
  flake.nixosModules.sakurasou = {self, ...}: {
    hardware.facter.reportPath = self + "/nix/hosts/sakurasou/facter.json";
  };
}
