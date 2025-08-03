{lib, ...}: {
  config = {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
      extraLocaleSettings = {
        LC_CTYPE = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_TIME = "en_DK.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_MESSAGES = "en_DK.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
      };
    };
  };
}
