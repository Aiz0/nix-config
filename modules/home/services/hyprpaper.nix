{
  config,
  lib,
  ...
}: {
  options.myHome.services.hyprpaper.enable = lib.mkEnableOption "hyprpaper wallpaper service";

  # TODO: general wallpaper selection
  config = lib.mkIf config.myHome.services.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        wallpaper =
          builtins.map (monitor: {
            monitor = monitor.plug;
            inherit (monitor.wallpaper) path;
          })
          config.myHome.hardware.monitors;
      };
    };
  };
}
