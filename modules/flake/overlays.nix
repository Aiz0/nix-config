{...}: {
  flake.overlays = {
    default = _final: prev: {
      # Lutris and Bottles fails to build right now
      # skips checks for oopenldap, remove when this is fixed
      # https://github.com/NixOS/nixpkgs/issues/513245
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    };
  };
}
