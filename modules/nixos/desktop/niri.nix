{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.desktop.niri = {
    enable = lib.mkEnableOption "Niri desktop environment";
  };

  config = lib.mkIf config.myNixOS.desktop.niri.enable {
    environment.systemPackages = [
      pkgs.xwayland-satellite-unstable
    ];
    security.pam.services.hyprlock = {};

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    myNixOS.desktop.enable = true;
  };
}
