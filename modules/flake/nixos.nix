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
      hardware = ../hardware;
      locale = ../locale;
      nixos = ../nixos;
      #snippets = ../snippets;
      users = ../users;
    };

    nixosConfigurations = let
      modules = self.nixosModules;
    in
      inputs.nixpkgs.lib.genAttrs [
        "miyabi"
        "sakurasou"
      ] (
        host:
          inputs.nixpkgs.lib.nixosSystem {
            modules = [
              ../../hosts/${host}
              inputs.niri.nixosModules.niri
              inputs.mikuboot.nixosModules.default
              inputs.disko.nixosModules.disko
              inputs.home-manager.nixosModules.home-manager
              modules.hardware
              modules.nixos
              #modules.snippets
              modules.users

              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {inherit self;};
                  backupFileExtension = "backup";
                };

                nixpkgs = {
                  overlays = [
                    inputs.nur.overlays.default
                    inputs.niri.overlays.niri
                  ];

                  config.allowUnfree = true;
                };
              }
            ];

            specialArgs = {inherit self;};
          }
      );
  };
}
