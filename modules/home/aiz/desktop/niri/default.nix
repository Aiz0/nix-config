{config, ...}: {
  programs.niri.settings = {
    environment."NIXOS_OZONE_WL" = "1";

    input = {
      keyboard = {
        repeat-delay = 275;
        repeat-rate = 40;
        # Remove next release
        xkb = {
          layout = "us";
          #variant = "colemak_dh";
        };
      };
      touchpad = {
        tap = true;
        dwt = true; # disable while typing
        natural-scroll = true;
        scroll-factor = 0.5;
        click-method = "clickfinger";
      };
    };

    binds = with config.lib.niri.actions; {
      "MOD+Return".action = spawn "ghostty";
      "MOD+Space".action = spawn "fuzzel";
    };
  };
}
