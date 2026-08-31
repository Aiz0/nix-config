_: {
  flake.homeModules.aiz = {
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = "auto";
    };
    home.shellAliases = {
      l = "eza -lah";
      la = "eza -a";
      ll = "eza -l";
      lla = "eza -la";
      ls = "eza";
      lt = "eza --tree";
      tree = "eza --tree";
    };
  };
}
