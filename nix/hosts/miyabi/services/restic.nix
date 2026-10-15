_: {
  flake.nixosModules.miyabi = {
    config,
    lib,
    self,
    ...
  }: {
    options.myBackup = {
      paths = lib.mkOption {
        type = lib.types.listOf lib.types.path;
        default = [];
        description = "Paths to include in the server backup";
      };
    };
    config = let
      localBackupPath = "/mnt/data/backups";
    in {
      sops.secrets.restic-password.sopsFile = self + "/secrets/restic-password.yaml";

      services.restic.backups.server-local = {
        initialize = true;
        repository = localBackupPath;
        passwordFile = config.sops.secrets.restic-password.path;
        paths =
          [
            "/etc/nixos"
            "/var/lib/nixos"
          ]
          ++ config.myBackup.paths;
        exclude = [
          "**/*.log"
          "**/cache"
        ];
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 6"
        ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          RandomizedDelaySec = "3h";
        };
      };
    };
  };
}
