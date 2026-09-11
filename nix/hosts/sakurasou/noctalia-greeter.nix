_: {
  flake.nixosModules.sakurasou = {
    services.displayManager.noctalia-greeter.settings = {
      appearance.wallpaper.path = builtins.path {path = ./assets/wallpaper-greeter.png;};

      appearance.palette = {
        primary = "#8b4a62";
        on_primary = "#ffffff";
        primary_container = "#ffd9e3";
        secondary = "#74565f";
        on_secondary = "#ffffff";
        tertiary = "#7d5636";
        on_tertiary = "#ffffff";
        error = "#ba1a1a";
        on_error = "#ffffff";
        surface = "#fff8f8";
        on_surface = "#22191c";
        surface_variant = "#f2dde2";
        on_surface_variant = "#514347";
        outline = "#837377";
        shadow = "#000000";
        # probably need better colors for these two
        hover = "#0e0e43";
        on_hover = "#fef29a";
      };
    };
  };
}
