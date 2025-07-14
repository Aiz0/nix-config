{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Aiz";
    userEmail = "dev@aiz.moe";
    delta.enable = true;
    package = pkgs.gitFull;
    extraConfig = {
      color.ui = true;
      github.user = "aiz0";
      push.autoSetupRemote = true;
    };
  };
}
