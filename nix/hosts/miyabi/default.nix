{
  inputs,
  self,
  ...
}: {
  config.flake.nixosConfigurations.miyabi = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.default
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
      self.nixosModules.miyabi
      self.nixosModules.tailnet
      self.nixosModules.podman
      self.nixosModules.prometheusNode
      self.nixosModules.amd-cpu
      self.nixosModules.nvidia-gpu
      self.nixosModules.aiz
    ];
    specialArgs = {inherit self;};
  };
}
