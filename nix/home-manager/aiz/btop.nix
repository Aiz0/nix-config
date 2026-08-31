_: {
  flake.homeModules.aiz = {
    programs.btop.enable = true;
    home.shellAliases = {
      top = "btop";
    };
  };
}
