{
  config,
  lib,
  self,
  ...
}: {
  options.myNixOS.services.noctalia.enable = lib.mkEnableOption "Noctalia desktop shell";

  imports = [
    self.inputs.noctalia.nixosModules.default
  ];

  config = lib.mkIf config.myNixOS.services.noctalia.enable {
    services.noctalia-shell.enable = true;
  };
}
