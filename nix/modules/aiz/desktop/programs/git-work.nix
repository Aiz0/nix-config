_: {
  flake.homeModules.aizDesktop = {osConfig, ...}: {
    programs.git = {
      includes = [
        {
          condition = "gitdir:~/work/";
          inherit (osConfig.age.secrets.gitWorkConfig) path;
        }
      ];
    };
  };
}
