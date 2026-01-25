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
        # launcher
        fuzzel
        # archives
        zip
        unzip

        # gui
        kdePackages.dolphin
        kdePackages.kservice
        kdePackages.baloo-widgets
        kdePackages.baloo
        kdePackages.ark
        kdePackages.ffmpegthumbs
        seahorse
        protonvpn-gui
        spotify
        freetube
        nur.repos.lonerOrz.helium

        # Dev
        nodejs
        deno
        pnpm
        pakku
        live-server

        # image, video, audio editing
        krita
        #kdePackages.kdenlive
        video-trimmer
        #aseprite
        tenacity
        ffmpeg
        imagemagick

        # chat
        element-desktop
        signal-desktop

        # games
        prismlauncher # minecraft-launcher
        osu-lazer-bin
        bottles

        # fonts
        source-code-pro
        roboto
        roboto-serif
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      pointerCursor = {
        enable = true;
        package = pkgs.posy-cursors;
        name = "Posy_Cursor_Black";
        dotIcons.enable = false;
      };
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Roboto" "Noto"];
        monospace = ["Source Code Pro" "Noto Sans Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };

    xdg.enable = true;
    programs.home-manager.enable = true;
    systemd.user.startServices = true; # Needed for auto-mounting agenix secrets.

    myHome = {
      profiles = {
        xdg.enable = true;
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
      };

      services = {
        jellyfin-mpv-shim = {
          enable = true;
          uosc.enable = true;
          extraScripts.enable = true;
        };
        gpg.enable = true;
        hypridle = {
          enable = true;
          autoSuspend = false; # turned off for now due to problems
        };
        hyprpaper.enable = true;
        trayscale.enable = true;
        vicinae.enable = true;
      };

      aiz = {
        desktop = {
          niri.enable = true;
        };
        programs = {
          git.enable = true;
          jujutsu.enable = true;
          noctalia.enable = true;
          ssh.enable = true;
          zen.enable = true;
          zed-editor.enable = true;
        };
      };
    };

    # Theming
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
