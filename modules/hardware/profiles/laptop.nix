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
      power-profiles-daemon.enable = true;

      # lid control
      logind = {
        lidSwitch = "hibernate";
        lidSwitchExternalPower = "hibernate";
        lidSwitchDocked = "ignore";
      };

      # default to us keyboard layout
      xserver.xkb = {
        layout = "us";
      };
    };
    # enable keyd for custom layout
    myNixOS.keyd.enable = true;
  };
}
