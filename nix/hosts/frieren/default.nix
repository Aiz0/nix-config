{
  inputs,
  self,
  ...
}: {
  config.flake.nixosConfigurations.frieren = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.disko.nixosModules.disko
      inputs.mikuboot.nixosModules.default
      inputs.niri.nixosModules.niri
      inputs.sops-nix.nixosModules.sops
      self.nixosModules.default
      self.nixosModules.frieren
      self.nixosModules.desktop
      self.nixosModules.podman
      self.nixosModules.amd-cpu
      self.nixosModules.amd-gpu
      self.nixosModules.framework-laptop13
      self.nixosModules.framework-laptop13-amd-ai-300
      self.nixosModules.keyd-colemak
      self.nixosModules.aiz
    ];
    specialArgs = {inherit self;};
  };
}
