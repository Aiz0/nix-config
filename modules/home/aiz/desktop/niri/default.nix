{config, ...}: {
  programs.niri.settings = {
    environment."NIXOS_OZONE_WL" = "1";

    input = {
      keyboard = {
        repeat-delay = 275;
        repeat-rate = 40;
      };
      touchpad = {
        tap = true;
        dwt = true; # disable while typing
        natural-scroll = true;
        click-method = "clickfinger";
      };
    };

    binds = with config.lib.niri.actions; {
      "MOD+Return".action = spawn "ghostty";
      "MOD+Space".action = spawn "fuzzel";
    };
  };
}
