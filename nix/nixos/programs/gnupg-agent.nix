_: {
  flake.nixosModules.default = {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
