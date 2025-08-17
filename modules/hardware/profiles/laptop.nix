{
  config,
  lib,
  ...
}: {
  options.myHardware.profiles.laptop.enable = lib.mkEnableOption "Laptop hardware configuration.";

  config = lib.mkIf config.myHardware.profiles.laptop.enable {
    services = {
      # power management
      upower.enable = true;

      tuned = {
        enable = lib.mkDefault true;
        settings.dynamic_tuning = true;
      };

      # lid control
      logind = {
        lidSwitch = "hibernate";
        lidSwitchExternalPower = "hibernate";
        lidSwitchDocked = "ignore";
      };
    };
    # enable keyd for custom layout
    myNixOS.keyd.enable = true;
  };
}
