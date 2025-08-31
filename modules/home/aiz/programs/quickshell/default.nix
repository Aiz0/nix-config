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
      ddcutil
      roboto
      inter
      cava
      gpu-screen-recorder
      xdg-desktop-portal-gnome
      self.inputs.noctalia.packages.${system}.default
    ];
    programs.quickshell = {
      enable = true;
      package = self.inputs.quickshell.packages.${pkgs.system}.default;
      configs = {
        inherit (self.inputs) noctalia;
      };
      activeConfig = "noctalia";
      systemd.enable = true;
    };
  };
}
