{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.myNixOS.profiles.base.enable = lib.mkEnableOption "base system configuration";

  config = lib.mkIf config.myNixOS.profiles.base.enable {
    time.timeZone = "Europe/Stockholm";
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

      # Set XDG directories
      sessionVariables = let
        local = "$HOME/local";
      in {
        XDG_CONFIG_HOME = local + "/config";
        XDG_CACHE_HOME = local + "/cache";
        XDG_STATE_HOME = local + "/state";
        XDG_DATA_HOME = local + "/share";
      };
    };
    programs = {
      dconf.enable = true; # Needed for home-manager

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };

    networking.networkmanager.enable = true;

    security = {
      rtkit.enable = true;
    };

    system = {
      configurationRevision = self.rev or self.dirtyRev or null;
      nixos.tags = ["base"];
    };
  };
}
