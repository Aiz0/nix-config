{
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
  config = {
    i18n = {
      glibcLocales = myGlibcLocales;
      defaultLocale = lib.mkDefault "en_SE.UTF-8";
      
    };
  };
}
