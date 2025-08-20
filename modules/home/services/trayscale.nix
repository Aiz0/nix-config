{
  config,
  osConfig,
  lib,
  ...
}: {
  options.myHome.services.trayscale.enable = lib.mkEnableOption "trayscale tailscale tray service";

  config = lib.mkIf (config.myHome.services.trayscale.enable && osConfig.myNixOS.services.tailscale.enable && osConfig.myNixOS.services.tailscale.operator == config.home.username) {
    services.trayscale.enable = true;
  };
}
