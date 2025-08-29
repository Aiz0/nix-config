{
  pkgs,
  self,
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
        file-roller
        protonvpn-gui
        spotify
        freetube

        # Dev
        nodejs
        deno
        pnpm
        pakku

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
        defaultApps.enable = true;
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
          displayName = "Aiz";
        };
      };

      services = {
        jellyfin-mpv-shim = {
          enable = true;
          uosc.enable = true;
        };
        hypridle = {
          enable = true;
          autoSuspend = false; # turned off for now due to problems
        };
        hyprpaper.enable = true;
        trayscale.enable = true;
      };

      aiz = {
        desktop = {
          niri.enable = true;
        };
        programs = {
          git.enable = true;
          jujutsu.enable = true;
          quickshell.enable = true;
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
    };
  };
}
