{
  config,
  lib,
  ...
}: {
  options.myHome.aiz.services.trayscale.enable = lib.mkEnableOption "trayscale tailscale tray service";

  # TODO: Require tailscale to be enabled
  config = lib.mkIf config.myHome.aiz.services.trayscale.enable {
    services.trayscale.enable = true;
  };
}
