{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHome.profiles.shell.enable = lib.mkEnableOption "basic shell environment";

  config = lib.mkIf config.myHome.profiles.shell.enable {
    home = {
      packages = with pkgs; [
        (lib.hiPrio uutils-coreutils-noprefix)
        curl
        btop
        wget
      ];
      shellAliases = {
        l = "eza -lah";
        tree = "eza --tree";
        top = "btop";
      };
    };

    programs = {
      fish = {
        enable = true;
        shellInit = ''
          function fish_greeting; end
          function fish_title; end
        '';
      };
      # shell prompt
      starship.enable = true;

      # ls alternative
      eza = {
        enable = true;
        enableFishIntegration = true;
        extraOptions = ["--group-directories-first" "--header"];
        git = true;
        icons = "auto";
      };
      # cd alternative
      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = ["--cmd cd"];
      };

      # cat alternative
      bat.enable = true;

      fzf.enable = true;

      ripgrep = {
        enable = true;
        arguments = ["--pretty"];
      };
      ripgrep-all.enable = true;

      zellij = {
        enable = true;
        enableFishIntegration = false;
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };
  };
}
