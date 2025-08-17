{
  config,
  osConfig,
  lib,
  self,
  ...
}: {
  options.myHome.services.jellyfin-mpv-shim = {
    enable = lib.mkEnableOption "Jellyfin mpv shim";
    uosc.enable = lib.mkEnableOption "Feature-rich minimalist proximity-based UI for MPV player.";
  };

  config = lib.mkIf config.myHome.services.jellyfin-mpv-shim.enable {
    services.jellyfin-mpv-shim = {
      enable = true;
      mpvConfig = {
        vo = "gpu-next";
        screenshot-format = "png";
        screenshot-template = "%{media-title}-%wH.%wM.%wS.%wT-#%#00n";
        slang = "eng,en";
      };

      mpvBindings = {
        "shift+x" = "set sub-delay 0";
      };

      settings = {
        thumbnail_osc_builtin = !config.myHome.services.jellyfin-mpv-shim.uosc.enable;
        lang = "eng";
        lang_filter_sub = true;
        screenshot_dir = "~/Pictures/screenshots";
        # set hostname explicitly so that it updates if hostname ever changes
        player_name = osConfig.networking.hostName;
      };
    };
    xdg.configFile = lib.mkIf config.myHome.services.jellyfin-mpv-shim.uosc.enable {
      jellyfin-mpv-shim-uosc = {
        source = self.inputs.mpv-uosc;
        target = "jellyfin-mpv-shim";
        recursive = true;
      };
      jellyfin-mpv-shim-uosc-conf = {
        source = ./uosc.conf;
        target = "jellyfin-mpv-shim/script-opts/uosc.conf";
      };
    };
  };
}
