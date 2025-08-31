{
  config,
  lib,
  ...
}: {
  options.myHardware.profiles.base.enable = lib.mkEnableOption "Base hardware configuration.";

  config = lib.mkIf config.myHardware.profiles.base.enable {
    console.useXkbConfig = true;

    hardware = {
      enableAllFirmware = true;

      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      logitech.wireless = {
        enable = true;
        enableGraphical = true;
      };
    };

    services = {
      fstrim.enable = true;

      logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandlePowerKeyLongPress = "poweroff";
      };
      # default to EurKEY keyboard layout
      xserver.xkb = {
        layout = "eu";
      };
    };
    zramSwap.enable = lib.mkDefault true;
  };
}
