_: {
  flake.nixosModules.default = {
    security = {
      # maybe move polkit elswhere
      polkit.enable = true;
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };
  };
}
