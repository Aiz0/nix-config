_: {
  flake.homeModules.aizSakurasou = {pkgs, ...}: {
    home.packages = [
      pkgs.eden
    ];
    xdg.desktopEntries = {
      "dev.eden_emu.eden" = {
        # This First entry is only the important one here.
        # As you can tell by the entry i have a "/user" directory in my home folder.
        # When eden is launched it looks for a "/user" directory in the current working directory.
        # if it exists then it uses that instead of the XDG base directories
        # When launched via the desktop entry, the current working directory is the my home directory.
        # This means that eden will use my "/user" directory for save files, etc.
        # This just simply changes the working directory to where the switch games are stored.
        settings.Path = "/home/aiz/user/games/switch/";
        # the rest here is copied from the default desktop entry
        name = "Eden";
        exec = "${pkgs.eden}/bin/eden %f";
        icon = "dev.eden_emu.eden";
        type = "Application";
        genericName = "Switch Emulator";
        comment = "Multiplatform FOSS Switch 1 emulator written in C++, derived from Yuzu and Sudachi";
        categories = ["Game" "Emulator" "Qt"];
        mimeType = ["application/x-nx-nro" "application/x-nx-nso" "application/x-nx-nsp" "application/x-nx-xci"];
        settings.Version = "1.0";
        settings.Keywords = "Nintendo;Switch;";
        settings.StartupWMClass = "eden";
      };
    };
  };
}
