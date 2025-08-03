{
  config,
  lib,
  ...
}: {
  imports = [
    ./niri.nix
  ];

  options.myNixOS.desktop.enable = lib.mkEnableOption "Desktop Environment";

  config = lib.mkIf config.myNixOS.desktop.enable {
    myNixOS.programs.plymouth.enable = true;
    myNixOS.programs.regreet.enable = true;
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    services = {
      udisks2.enable = true;
      gvfs.enable = true;

      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };

      avahi.enable = true;
      printing.enable = true;
      system-config-printer.enable = true;
    };

    system.nixos.tags = ["desktop"];
  };
}
