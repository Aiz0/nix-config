{
  config,
  lib,
  ...
}: {
  options.myNixOS.programs.nix.enable = lib.mkEnableOption "sane nix configuration";

  config = lib.mkIf config.myNixOS.programs.nix.enable {
    # garbage collection
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 3d";

        persistent = true;
        randomizedDelaySec = "60min";
      };
      optimise = {
        automatic = true;
        persistent = true;
        randomizedDelaySec = "60min";
      };

      settings = {
        # don't pollute home with nix files
        use-xdg-base-directories = true;

        experimental-features = [
          "flakes"
          "nix-command"
        ];

        builders-use-substitutes = true;
        substituters = [
          "https://cache.nixos.org/"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];

        trusted-users = ["@admin" "@wheel"];
      };
    };
    programs.nix-ld.enable = true;
  };
}
