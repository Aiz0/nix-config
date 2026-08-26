_: {
  flake.nixosModules.desktop = {
    config,
    lib,
    pkgs,
    ...
  }: let
    steamHome = "$XDG_DATA_HOME/homes/steam";
  in {
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
        gamescopeSession.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
      };
    };
    # Wrapper scripts for Steam and SGDBoop to use a custom home directory
    # Because I'm annoyed by steam putting dotfiles in my home directory
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "steam" ''
        export HOME="${steamHome}"
        mkdir -p ${steamHome}
        exec ${lib.getExe config.programs.steam.package} "$@"
      '')

      (pkgs.writeShellScriptBin "SGDBoop" ''
        export HOME="${steamHome}"
        exec ${lib.getExe pkgs.sgdboop} "$@"
      '')
    ];
  };
}
