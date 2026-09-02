_: {
  flake.nixosModules.default = {
    pkgs,
    lib,
    ...
  }: {
    environment = {
      systemPackages = with pkgs; [
        (lib.hiPrio uutils-coreutils-noprefix)
        git
        helix
        btop
        wget
        curl
        gtrash
        # TODO: add with devshell
        nixd
        alejandra
      ];
    };
  };
}
