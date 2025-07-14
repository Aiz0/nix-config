{config, ...}: {
  programs.niri.settings = {
    environment."NIXOS_OZONE_WL" = "1";
    binds = with config.lib.niri.actions; {
      "MOD+Return".action = spawn "ghostty";
      "MOD+Space".action = spawn "fuzzel";
    };
  };
}
