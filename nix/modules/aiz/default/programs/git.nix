_: {
  flake.homeModules.aiz = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Aiz";
          email = "dev@aiz.moe";
        };
        color.ui = true;
        github.user = "aiz0";
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
      };
      package = pkgs.gitFull;
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
