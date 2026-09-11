_: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    ...
  }: {
    # Each host sets its own wallpaper and preferred monitor
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        appearance = {
          scheme = "Synced";
          scheme_selector_position = "hidden";
          hide_logo = true;
          theme_mode = "light";
          palette = {
            primary = lib.mkDefault "#fff59b";
            on_primary = lib.mkDefault "#0e0e43";
            secondary = lib.mkDefault "#a9aefe";
            on_secondary = lib.mkDefault "#0e0e43";
            tertiary = lib.mkDefault "#9BFECE";
            on_tertiary = lib.mkDefault "#0e0e43";
            error = lib.mkDefault "#FD4663";
            on_error = lib.mkDefault "#0e0e43";
            surface = lib.mkDefault "#070722";
            on_surface = lib.mkDefault "#f3edf7";
            surface_variant = lib.mkDefault "#11112d";
            on_surface_variant = lib.mkDefault "#7c80b4";
            outline = lib.mkDefault "#21215F";
            shadow = lib.mkDefault "#070722";
            hover = lib.mkDefault "#9BFECE";
            on_hover = lib.mkDefault "#0e0e43";
          };
          wallpaper = {
            fill_mode = "crop";
          };
          output = {
            scale = lib.mkDefault 1.0;
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
