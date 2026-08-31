_: {
  flake.homeModules.aiz = {
    programs.nix-your-shell = {
      enable = true;
      nix-output-monitor.enable = true;
    };
  };
}
