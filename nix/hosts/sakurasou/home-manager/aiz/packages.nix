_: {
  flake.homeModules.aizSakurasou = {pkgs, ...}: {
    home.packages = [
      pkgs.aseprite
      pkgs.olympus
    ];
  };
}
