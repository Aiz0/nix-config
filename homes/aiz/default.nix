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
        # archives
        zip
        unzip

        # gui
        file-roller
        protonvpn-gui
        krita

        # fonts
        source-code-pro
        roboto
        roboto-serif
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
        serif = ["Roboto Serif"];
        sansSerif = ["Roboto"];
        monospace = ["Source Code Pro"];
        emoji = ["Noto Color Emoji"];
      };
    };

    xdg.enable = true;
    programs.home-manager.enable = true;

    myHome = {
      profiles = {
        xdg.enable = true;
        shell.enable = true;
        defaultApps.enable = true;
      };

      programs = {
        fastfetch.enable = true;
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
        services = {
          hypridle.enable = true;
          hyprpaper.enable = true;
          trayscale.enable = true;
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
