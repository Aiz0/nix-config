{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.myHome.aiz.programs.quickshell.enable = lib.mkEnableOption "quickshell desktop shell";

  config = lib.mkIf config.myHome.aiz.programs.quickshell.enable {
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
      configs = {
        noctalia = self.inputs.noctalia;
      };
      activeConfig = "noctalia";
      systemd.enable = true;
    };
  };
}
