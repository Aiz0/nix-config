_: {
  flake.nixosModules.default = {
    config,
    lib,
    pkgs,
    ...
  }: let
    enSE = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/bminor/glibc/a6eb8285d9bfb7ec0875b85ca356e833ff964d4f/localedata/locales/en_SE";
      sha256 = "sha256-9Nz/xZfcaOJ/3DV+FOiOb6g8E3HvFHCu/jokMWSGDVU="; # fix with nix-prefetch-url
    };

    myGlibcLocales = pkgs.glibcLocales.override {
      glibc = pkgs.glibc.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            cp ${enSE} localedata/locales/en_SE
          '';
      });
    };
  in {
    i18n = {
      # glibcLocales = myGlibcLocales;
      defaultLocale = lib.mkDefault "en_DK.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = config.i18n.defaultLocale;
        LC_IDENTIFICATION = config.i18n.defaultLocale;
        LC_MEASUREMENT = config.i18n.defaultLocale;
        LC_MONETARY = config.i18n.defaultLocale;
        LC_NAME = config.i18n.defaultLocale;
        LC_NUMERIC = config.i18n.defaultLocale;
        LC_PAPER = config.i18n.defaultLocale;
        LC_TELEPHONE = config.i18n.defaultLocale;
        LC_TIME = config.i18n.defaultLocale;
      };
    };
  };
}
