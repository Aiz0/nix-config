{
  pkgs,
  config,
  self,
  lib,
  ...
}: {
  imports = [
    self.homeModules.default
  ];

  config = {
    home = {
      username = "aiz";
      homeDirectory = "/home/aiz";
      stateVersion = "25.05";

      packages = with pkgs; [
        # Dev
        nodejs
        deno
        pnpm
        pakku
        live-server
      ];
    };

    programs = {
      lutris = {
        enable = true;
      };
    };

    programs.home-manager.enable = true;
    systemd.user.startServices = true; # Needed for auto-mounting agenix secrets.

    myHome = {
      profiles = {
        shell.enable = true;
        defaultApps = {
          enable = true;
          forceMimeAssociations = true;
        };
        avatar.path = builtins.path {path = ./assets/avatar.webp;};
      };

      programs = {
        fastfetch = {
          enable = true;
          logo = builtins.path {path = ./assets/nix-snowflake-mashiro.png;};
        };
        ghostty.enable = true;
        hyprlock = {
          enable = true;
          displayName = lib.mkDefault "Aiz";
        };
        vicinae.enable = true;
      };

      services = {
        jellyfin-mpv-shim = {
          enable = true;
          uosc.enable = true;
          extraScripts.enable = true;
        };
        gpg.enable = true;
        trayscale.enable = true;
      };

      aiz = {
        desktop = {
          niri.enable = true;
        };
        programs = {
          git.enable = true;
          jujutsu.enable = true;
          noctalia = {
            enable = true;
            wallpaper.enable = true;
            idle.enable = true;
          };
          ssh.enable = true;
          zen.enable = true;
          zed-editor.enable = true;
        };
      };
    };
  };
}
