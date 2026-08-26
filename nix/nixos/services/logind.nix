_: {
  flake.nixosModules.default = {
    services.logind.settings.Login = {
      HandlePowerKey = "sleep";
      HandlePowerKeyLongPress = "poweroff";
      # lid control
      # not sure i want these here
      HandleLidSwitch = "sleep";
      HandleLidSwitchExternalPower = "sleep";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
