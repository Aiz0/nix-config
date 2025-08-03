{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aiz.nix
  ];

  options.myUsers = let
    mkUser = user: {
      enable = lib.mkEnableOption "${user}.";

      password = lib.mkOption {
        default = null;
        description = "Hashed password for ${user}.";
        type = lib.types.nullOr lib.types.str;
      };
    };
  in {
    defaultGroups = lib.mkOption {
      description = "Default groups for desktop users";
      default = ["networkmanager" "wheel"];
      type = lib.types.listOf lib.types.str;
    };
    root.enable = lib.mkEnableOption "root user configuration." // {default = true;};
    aiz = mkUser "aiz";
  };

  config = lib.mkIf (config.myUsers.root.enable or config.myUsers.aiz.enable) {
    # Shells
    programs.fish.enable = true; # preferred shell
    programs.zsh.enable = true; # for root

    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = true; # TODO: add passwords declaratively and disable
    };
  };
}
