_: {
  flake.homeModules.aiz = {pkgs, ...}: {
    home.packages = with pkgs; [
      curl
      wget
    ];
  };
}
