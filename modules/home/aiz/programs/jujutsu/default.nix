{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.programs.jujutsu.enable = lib.mkEnableOption "jujutsu version control";

  config = lib.mkIf config.myHome.aiz.programs.jujutsu.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "Aiz";
          email = "dev@aiz.moe";
        };
        ui = {
          pager = "less -FRX";
          default-command = "st";
          diff-editor = ":builtin";
        };
      };
    };
  };
}
