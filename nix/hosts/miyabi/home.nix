{inputs, ...}: {
  flake.nixosModules.miyabi = {self, ...}: {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager = {
      backupFileExtension = "backup";
      extraSpecialArgs = {inherit self;};
      useGlobalPkgs = true;
      useUserPackages = true;

      users.aiz = {
        home = {
          homeDirectory = "/home/aiz";
          stateVersion = "25.05";
          username = "aiz";
        };

        imports = [
          self.homeModules.aiz
        ];
      };
    };
  };
}
