{
  config,
  lib,
  self,
  ...
}: {
  imports = [
    self.inputs.vicinae.homeManagerModules.default
  ];
  options.myHome.services.vicinae.enable = lib.mkEnableOption "Vicinae raycast inspired launcher";

  config = lib.mkIf config.myHome.services.vicinae.enable {
    services.vicinae.enable = true;
  };
}
