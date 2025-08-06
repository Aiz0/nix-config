{pkgs, ...}: {
  imports = [
    ./desktop
    ./programs
    ./services
    ./assets
  ];
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
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "qt5ct";
  #   style.name = "breeze";
  # };
}
