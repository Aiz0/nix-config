_: {
  flake.homeModules.aiz = {
    programs.ripgrep = {
      enable = true;
      arguments = ["--pretty"];
    };
    programs.ripgrep-all.enable = true;
  };
}
