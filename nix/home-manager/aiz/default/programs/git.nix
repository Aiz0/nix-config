_: {
  flake.homeModules.aiz = {
    pkgs,
    osConfig,
    ...
  }: {
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
      includes = [
        {
          condition = "gitdir:~/work/";
          inherit (osConfig.age.secrets.gitWorkConfig) path;
        }
      ];
    };
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
