_: {
  flake.nixosModules.default = {
    environment.variables.NH_FLAKE = "github:aiz0/nix-config";
    programs.nh.enable = true;
  };
}
