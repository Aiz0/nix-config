{
  config,
  lib,
  self,
  ...
}: {
  options.myNixOS.services.shoko = {
    enable = lib.mkEnableOption "Shoko anime";
  };

  imports = [
    "${self.inputs.shoko-anime}/nixos/modules/services/misc/shoko.nix"
  ];

  config = lib.mkIf config.myNixOS.services.shoko.enable {
    services.shoko = {
      enable = true;
      openFirewall = true; # port 8111
    };
  };
}
