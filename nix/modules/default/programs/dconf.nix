_: {
  flake.nixosModules.default = {
    programs = {
      dconf.enable = true;
    };
  };
}
