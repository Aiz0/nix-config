{
  inputs,
  self,
  ...
}: {
  config.flake.nixosConfigurations.sakurasou = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.mikuboot.nixosModules.default
      inputs.niri.nixosModules.niri
      inputs.sops-nix.nixosModules.sops
      self.nixosModules.default
      self.nixosModules.sakurasou
      self.nixosModules.desktop
      self.nixosModules.podman
      self.nixosModules.qbittorrent
      self.nixosModules.amd-cpu
      self.nixosModules.amd-gpu
      self.nixosModules.aiz
    ];
    specialArgs = {inherit self;};
  };
}
