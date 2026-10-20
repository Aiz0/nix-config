_: {
  flake.homeModules.syncthing = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkIf mkMerge;

    cfg = config.myOptions.syncthing;

    enabledFolder = folder:
      mkIf folder.enable {
        "${folder.path}" = {
          inherit (folder) devices id ignorePatterns label versioning;
        };
      };
  in {
    config = mkIf cfg.enable {
      assertions = let
        folders =
          lib.mapAttrsToList
          (folderName: value: value // {inherit folderName;})
          cfg.folders;

        enabled = lib.filter (f: f.enable or false) folders;

        byPath = lib.groupBy (f: f.path) enabled;
        clashes = lib.filter (g: lib.length g > 1) (lib.attrValues byPath);
      in [
        {
          assertion = clashes == [];
          message =
            "Duplicate folder paths: "
            + lib.concatMapStringsSep "\n"
            (g:
              "${(lib.head g).path} used by: "
              + lib.concatMapStringsSep ", " (f: f.folderName) g)
            clashes;
        }
        {
          assertion = (cfg.cert == null) == (cfg.key == null);
          message = "myOptions.syncthing cert and key must be configured together.";
        }
      ];

      services.syncthing = {
        inherit (cfg) cert key;

        enable = true;
        overrideDevices = false;
        overrideFolders = false;

        settings = {
          devices =
            lib.mapAttrs (_: device: {
              inherit (device) id introducer;
            })
            cfg.devices;

          folders = mkMerge [
            (enabledFolder cfg.folders.sync)
            (enabledFolder cfg.folders.obsidian)
            (enabledFolder cfg.folders.backups)
          ];
        };
      };
    };
  };
}
