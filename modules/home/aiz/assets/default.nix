{...}: {
  #TODO: put in module instead
  xdg.configFile.avatar = {
    enable = true;
    source = ./avatar.webp;
    target = "avatar";
  };
  xdg.configFile.wallpaper = {
    enable = true;
    source = ./wallpaper.jxl;
    target = "wallpaper.jxl";
  };
}
