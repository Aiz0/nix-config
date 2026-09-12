_: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = [
        pkgs.git
        pkgs.nh
        pkgs.nixd
        pkgs.just
        pkgs.sops
        pkgs.ssh-to-age
      ];

      shellHook = ''
        export FLAKE="." NH_FLAKE="."
        echo "🌸 Welcome to the... devShell!"
      '';
    };
  };
}
