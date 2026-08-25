_: {
  flake.nixosModules.default = {
    nix.daemonCPUSchedPolicy = "idle";

    nix.settings = {
      # don't pollute home with nix files
      use-xdg-base-directories = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      extra-substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];

      extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      max-free = 5 * 1024 * 1024 * 1024;
      min-free = 1024 * 1024 * 1024;
    };

    nix.gc = {
      automatic = true;
      options = "--delete-older-than 3d";
      persistent = true;
      randomizedDelaySec = "60min";
    };

    nix.optimise = {
      automatic = true;
      persistent = true;
      randomizedDelaySec = "60min";
    };
  };
}
