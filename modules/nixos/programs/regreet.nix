{
  config,
  lib,
  ...
}: {
  options.myNixOS.regreet.enable = lib.mkOption {
    description = "Enable regreet Display Manager";
    default = true;
    type = lib.types.bool;
  };

  config = lib.mkIf config.myNixOS.regreet.enable {
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
