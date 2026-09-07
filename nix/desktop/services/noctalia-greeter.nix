_: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    # Each host sets its own wallpaper and preferred monitor
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        appearance = {
          scheme = "Noctalia";
          scheme_selector_position = "hidden";
          hide_logo = true;
          theme_mode = "light";
          wallpaper = {
            fill_mode = "center";
          };
        };
      };
      cursorTheme = {
        package = pkgs.posy-cursors;
        name = "Posy_Cursor_Black";
      };
    };
  };
}
