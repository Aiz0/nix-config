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
        ipc = "on";
        preload = builtins.map (monitor: monitor.wallpaper.path) config.myHome.hardware.monitors;
        wallpaper = builtins.map (monitor: "${monitor.plug},${monitor.wallpaper.path}") config.myHome.hardware.monitors;
      };
    };
  };
}
