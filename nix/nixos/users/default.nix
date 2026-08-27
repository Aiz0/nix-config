_: {
  flake.nixosModules.default = {pkgs, ...}: {
    users.defaultUserShell = pkgs.zsh;
    users.mutableUsers = true; # TODO: add passwords declaratively and disable
  };
}
