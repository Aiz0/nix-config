_: {
  flake.homeModules.aizDesktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      source-code-pro
      roboto
      roboto-serif
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Roboto" "Noto"];
        monospace = ["Source Code Pro" "Noto Sans Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
