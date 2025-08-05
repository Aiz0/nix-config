{
  self,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    material-symbols
    cava
    gpu-screen-recorder
    xdg-desktop-portal-gnome
  ];
  programs.quickshell = {
    enable = true;
    package = self.inputs.quickshell.packages.${pkgs.system}.default.withModules (with pkgs; [
      qt6.qtimageformats
      qt6.qtmultimedia
      qt6.qtdeclarative
    ]);
    systemd.enable = true;
  };
}
