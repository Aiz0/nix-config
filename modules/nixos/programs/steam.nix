{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.programs.steam = {
    enable = lib.mkEnableOption "Steam client configuration";
    session.enable = lib.mkEnableOption "Steam + Gamescope desktop session";
    steamHome = {
      enable = lib.mkEnableOption "Wraps steam to use a custom home directory";
      path = lib.mkOption {
        type = lib.types.string;
        default = "$XDG_DATA_HOME/homes/steam";
        description = "Path to the Steam home directory";
      };
    };
  };

  config = lib.mkIf config.myNixOS.programs.steam.enable {
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = lib.makeSearchPathOutput "steamcompattool" "" config.programs.steam.extraCompatPackages;
    };

    hardware.steam-hardware.enable = true;

    programs = {
      gamescope.enable = true;

      steam = {
        enable = true;
        dedicatedServer.openFirewall = true;
        extest.enable = true;
        extraCompatPackages = with pkgs; [proton-ge-bin];
        gamescopeSession.enable = config.myNixOS.programs.steam.session.enable;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
      };
    };
    # Create the wrapper script only if enableWrapped is true
    environment.systemPackages = lib.mkIf config.myNixOS.programs.steam.steamHome.enable [
      (pkgs.writeShellScriptBin "steam" ''
        export HOME="${config.myNixOS.programs.steam.steamHome.path}"
        mkdir -p ${config.myNixOS.programs.steam.steamHome.path}
        exec ${lib.getExe config.programs.steam.package} "$@"
      '')
    ];
  };
}
