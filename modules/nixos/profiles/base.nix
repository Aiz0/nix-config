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

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      nh.enable = true;
      # TODO: add ssh known hosts
      # ssh.knownHosts = config.mySnippets.ssh.knownHosts;
    };

    networking.networkmanager.enable = true;

    security = {
      polkit.enable = true;
      rtkit.enable = true;

      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    system = {
      configurationRevision = self.rev or self.dirtyRev or null;
      nixos.tags = ["base"];
    };
  };
}
