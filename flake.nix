{
  description = "Aiz's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikuboot = {
      url = "gitlab:evysgarden/mikuboot";
      inputs.nixpkgs.follows = ""; # only useful for the package output
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    accept-flake-config = true;
  };

  outputs = {self, ...}: let
    allSystems = [
      "x86_64-linux"
    ];

    forAllSystems = func: (self.inputs.nixpkgs.lib.genAttrs allSystems func);

    forAllLinuxHosts = self.inputs.nixpkgs.lib.genAttrs [
      "nixos-vivobook"
    ];

    overlays = [
      self.inputs.nur.overlays.default
      self.inputs.niri.overlays.niri
    ];
  in {
    diskoConfigurations = {
      luks-btrfs-subvolumes = ./modules/disko/luks-btrfs-subvolumes.nix;
    };

    homeManagerModules = {
      aiz = ./modules/home/aiz;
      # snippets = ./modules/snippets;
    };
    nixosModules = {
      #hardware = ./modules/nixos/hardware;
      #locale-en-us = ./modules/nixos/locale/en-us;
      nixos = ./modules/nixos/os;
      #snippets = ./modules/snippets;
      users = ./modules/users;
    };

    nixosConfigurations = forAllLinuxHosts (
      host:
        self.inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {inherit self;};

          modules = [
            ./hosts/${host}
            self.inputs.niri.nixosModules.niri
            self.inputs.mikuboot.nixosModules.default
            self.inputs.home-manager.nixosModules.home-manager
            self.inputs.disko.nixosModules.disko
            self.nixosModules.nixos
            self.nixosModules.users
            {
              home-manager = {
                backupFileExtension = "backup";
                extraSpecialArgs = {inherit self;};
                useGlobalPkgs = true;
                useUserPackages = true;
                users.aiz = import self.homeManagerModules.aiz;
              };

              nixpkgs = {
                inherit overlays;
                config.allowUnfree = true;
              };
            }
          ];
        }
    );

    formatter = forAllSystems (
      # format with alejandra
      system: self.inputs.nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
