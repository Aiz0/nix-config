_: {
  flake.nixosModules.desktop = {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}
