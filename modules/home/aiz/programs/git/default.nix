{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: {
  options.myHome.aiz.programs.git.enable = lib.mkEnableOption "git version control";

  config = lib.mkIf config.myHome.aiz.programs.git.enable {
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
