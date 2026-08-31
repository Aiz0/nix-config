_: {
  flake.homeModules.aiz = {
    programs.zellij = {
      enable = true;
      # honestly don't remember why this is false
      enableFishIntegration = false;
    };
  };
}
