{
  self,
  pkgs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    package = self.inputs.quickshell.packages.${pkgs.system}.default.withModules (with pkgs; [
      qt6.qtimageformats
      qt6.qtmultimedia
      qt6.qtdeclarative
      pkgs.kdePackages.qt5compat
      cava
      gpu-screen-recorder
      xdg-desktop-portal-gnome
      material-symbols
    ]);
    systemd.enable = true;
  };
}
