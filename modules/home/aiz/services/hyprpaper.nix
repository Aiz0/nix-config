{config, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = ["${config.xdg.configHome}/wallpaper.jxl"];
      wallpaper = ",${config.xdg.configHome}/wallpaper.jxl";
    };
  };
}
