_: {
  flake.homeModules.aizDesktop = {
    pkgs,
    config,
    ...
  }: {
    home.packages = [pkgs.nur.repos.ilya-fedin.qt6ct];
    # Theming
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      gtk4.theme = null;
    };
    home.sessionVariables."QT_QPA_PLATFORMTHEME" = "qt6ct";
    qt = {
      enable = true;
      qt6ctSettings = {
        Appearance = {
          style = "Breeze";
          custom_palette = true;
          color_scheme_path = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
          icon_theme = "breeze-dark";
          standard_dialogs = "xdgdesktopportal";
        };
      };
      style = {
        package = with pkgs; [kdePackages.breeze];
      };
    };
  };
}
