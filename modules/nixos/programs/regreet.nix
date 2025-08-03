{
  config,
  lib,
  ...
}: {
  options.myNixOS.programs.regreet.enable = lib.mkOption {
    description = "Enable regreet Display Manager";
    default = false;
    type = lib.types.bool;
  };

  config = lib.mkIf config.myNixOS.programs.regreet.enable {
    programs.regreet = {
      enable = true;
      theme.name = "Adwaita-dark";
      settings = {
        background = {
          #TODO: move to separate configuration
          path = builtins.path {path = ../../../assets/frieren.jpg;};
          fit = "Cover";
        };
      };
    };
  };
}
