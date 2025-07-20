{self, pkgs, ...}:{
  
  #packages required for Noctalia
  home.packages = with pkgs; [
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    cava
    gpu-screen-recorder
    xdg-desktop-portal-gnome
    material-symbols
  ];
  
  programs.quickshell = {
    enable = true;
    package = self.inputs.quickshell.packages.${pkgs.system}.default;
    systemd.enable = true;
  };

}