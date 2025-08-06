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

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
  programs.fish.enable = true;
}
