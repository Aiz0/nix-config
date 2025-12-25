{
  config,
  lib,
  ...
}: {
  options.myNixOS.services.shoko = {
    enable = lib.mkEnableOption "Shoko anime";
  };

  config = lib.mkIf config.myNixOS.services.shoko.enable {
    services.shoko = {
      enable = true;
      openFirewall = true; # port 8111
    };
  };
}
