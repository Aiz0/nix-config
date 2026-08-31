{
  self,
  inputs,
  ...
}: {
  flake = {
    diskoConfigurations = {
      luks-btrfs-subvolumes = ../disko/luks-btrfs-subvolumes.nix;
    };

    nixosModules = {
      nixos = ../nixos;
    };

    nixosConfigurations = let
      modules = self.nixosModules;
    in
      inputs.nixpkgs.lib.genAttrs [
        "frieren"
      ] (
        host:
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ../../hosts/${host}
              inputs.nur.modules.nixos.default
              modules.nixos
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {inherit self;};
                  backupFileExtension = "backup";
                };
              }
            ];

            specialArgs = {inherit self;};
          }
      );
  };
}
