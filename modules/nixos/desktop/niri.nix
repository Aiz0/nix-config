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
    # Fix for dolphin not knowing what applications you have
    # https://github.com/NixOS/nixpkgs/issues/409986
    environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

    environment.systemPackages = [
      pkgs.xwayland-satellite-unstable
    ];
    home-manager.sharedModules = [
      {
        myHome.aiz.desktop.niri = {
          enable = true;
        };
      }
    ];
    security.pam.services.hyprlock = {};

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    myNixOS.desktop.enable = true;
  };
}
