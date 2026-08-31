_: {
  flake.homeModules.aiz = {
    pkgs,
    lib,
    ...
  }: {
    home = {
      packages = [(lib.hiPrio pkgs.uutils-coreutils-noprefix)];
    };
  };
}
