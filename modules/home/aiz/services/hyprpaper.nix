{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.services.hyprpaper.enable = lib.mkEnableOption "hyprpaper wallpaper service";

  # TODO: general wallpaper selection
  config = lib.mkIf config.myHome.aiz.services.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = ["${config.xdg.configHome}/wallpaper.jxl"];
        wallpaper = ",${config.xdg.configHome}/wallpaper.jxl";
      };
    };
  };
}
