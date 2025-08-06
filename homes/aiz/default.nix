{
  config,
  pkgs,
  lib,
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
        neofetch
        # archives
        zip
        unzip

        # gui
        nautilus # gnome file manager
        file-roller
        oculante # image viewer
        protonvpn-gui
        krita
      ];

      pointerCursor = {
        enable = true;
        package = pkgs.posy-cursors;
        name = "Posy_Cursor_Black";
        dotIcons.enable = false;
      };
    };
    xdg.enable = true;
    programs.home-manager.enable = true;

    myHome = {
      profiles = {
        xdg.enable = true;
        shell.enable = true;
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
  };
}
