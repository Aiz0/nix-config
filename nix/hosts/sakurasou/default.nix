{
  inputs,
  self,
  ...
}: {
  config.flake.nixosConfigurations.sakurasou = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.default
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.mikuboot.nixosModules.default
      inputs.niri.nixosModules.niri
      self.nixosModules.sakurasou
      self.nixosModules.tailnet
      self.nixosModules.desktop
      self.nixosModules.podman
      self.nixosModules.amd-cpu
      self.nixosModules.amd-gpu
      self.nixosModules.aiz
    ];
    specialArgs = {inherit self;};
  };
}
