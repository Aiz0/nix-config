{
  config,
  lib,
  ...
}: {
  options.myHome.services.trayscale.enable = lib.mkEnableOption "trayscale tailscale tray service";

  # TODO: Require tailscale to be enabled
  config = lib.mkIf config.myHome.services.trayscale.enable {
    services.trayscale.enable = true;
  };
}
