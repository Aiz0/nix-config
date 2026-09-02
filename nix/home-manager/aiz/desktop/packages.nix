_: {
  flake.homeModules.aizDesktop = {pkgs, ...}: {
    # TODO: think about if certain stuff should be in separate modules
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kservice
      kdePackages.baloo-widgets
      kdePackages.baloo
      kdePackages.ark
      kdePackages.ffmpegthumbs
      kdePackages.qtsvg

      seahorse

      proton-vpn

      spotify
      freetube
      nur.repos.Ev357.helium

      # image, video, audio editing
      krita
      video-trimmer
      tenacity
      ffmpeg
      imagemagick
      easyeffects

      # chat
      element-desktop
      signal-desktop

      # games
      prismlauncher # minecraft-launcher
      osu-lazer-bin
      bottles
      protonplus
      r2modman

      # Dev
      nodejs
      deno
      pnpm
      pakku
    ];
  };
}
