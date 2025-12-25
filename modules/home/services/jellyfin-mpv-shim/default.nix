{
  config,
  osConfig,
  lib,
  self,
  ...
}: let
  cfg = config.myHome.services.jellyfin-mpv-shim;
in {
  options.myHome.services.jellyfin-mpv-shim = {
    enable = lib.mkEnableOption "Jellyfin mpv shim";
    uosc.enable = lib.mkEnableOption "Feature-rich minimalist proximity-based UI for MPV player.";
    extraScripts.enable = lib.mkEnableOption "Extra scripts for mpv";
  };

  config = lib.mkIf cfg.enable {
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

        # crop.lua
        # ==========
        # start cropping
        "c" = "script-message-to crop start-crop hard";
        "alt+c" = "script-message-to crop start-crop soft";
        # delogo mode can be used like so
        "l" = "script-message-to crop start-crop delogo";
        # remove the crop
        "d" = "vf del -1";

        # or use the ready-made "toggle" binding
        "C" = "script-message-to crop toggle-crop hard";

        # remove the soft zoom
        "0" = "set video-pan-x 0; set video-pan-y 0; set video-zoom 0";

        # encode.lua
        # ============
        # use default profile (makes vp8 webms)
        "e" = "script-message-to encode set-timestamp";

        # use custom webm profile, the argument name must correspond to an existing .conf file (see script-opts/)
        "alt+e" = "script-message-to encode set-timestamp encode_webm";

        # use custom profile
        "E" = "script-message-to encode set-timestamp encode_slice";
      };

      settings = {
        thumbnail_osc_builtin = !cfg.uosc.enable;
        lang = "eng";
        lang_filter_sub = true;
        screenshot_dir = "~/Pictures/screenshots";
        # set hostname explicitly so that it updates if hostname ever changes
        player_name = osConfig.networking.hostName;
        # Retry for 1 minute before showing window
        # should be good enough for most cases
        connect_retry_mins = 1;
        remote_kbps = 2147483;
      };
    };
    xdg.configFile =
      (lib.optionalAttrs cfg.uosc.enable {
        jellyfin-mpv-shim-uosc = {
          source = "${self.inputs.mpv-uosc}/scripts/uosc";
          target = "jellyfin-mpv-shim/scripts/uosc";
          recursive = true;
        };
        jellyfin-mpv-shim-uosc-fonts = {
          source = "${self.inputs.mpv-uosc}/fonts";
          target = "jellyfin-mpv-shim/fonts";
          recursive = true;
        };
        jellyfin-mpv-shim-uosc-conf = {
          source = ./uosc.conf;
          target = "jellyfin-mpv-shim/script-opts/uosc.conf";
        };
      })
      // (lib.optionalAttrs cfg.extraScripts.enable {
        jellyfin-mpv-shim-scripts-crop = {
          source = "${self.inputs.mpv-scripts}/scripts/crop.lua";
          target = "jellyfin-mpv-shim/scripts/crop.lua";
        };
        jellyfin-mpv-shim-scripts-encode = {
          source = "${self.inputs.mpv-scripts}/scripts/encode.lua";
          target = "jellyfin-mpv-shim/scripts/encode.lua";
        };
        jellyfin-mpv-shim-scripts-encode-webm-conf = {
          source = ./encode_webm.conf;
          target = "jellyfin-mpv-shim/script-opts/encode-webm.conf";
        };
        jellyfin-mpv-shim-scripts-encode-slice-conf = {
          source = ./encode_slice.conf;
          target = "jellyfin-mpv-shim/script-opts/encode-slice.conf";
        };
        jellyfin-mpv-shim-crop-conf = {
          source = ./crop.conf;
          target = "jellyfin-mpv-shim/script-opts/crop.conf";
        };
      });
  };
}
