{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.myNixOS.profiles.base.enable = lib.mkEnableOption "base system configuration";

  config = lib.mkIf config.myNixOS.profiles.base.enable {
    environment = {
      systemPackages = with pkgs; [
        (lib.hiPrio uutils-coreutils-noprefix)
        git
        helix
        btop
        wget
        curl
        gtrash
        # TODO: add with devshell
        nixd
        alejandra
      ];
    };

    programs = {
      dconf.enable = true; # Needed for home-manager
    };
  };
}
