{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myNixOS.programs.plymouth = {
    enable = lib.mkOption {
      default = false;
      description = "Enable Plymouth boot splash";
      type = lib.types.bool;
    };
    mikuboot = lib.mkOption {
      default = config.myNixOS.programs.plymouth.enable;
      description = "Enable Mikuboot theme";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.myNixOS.programs.plymouth.enable {
    boot = {
      plymouth = lib.mkMerge [
        {
          enable = true;
        }
        (lib.mkIf config.myNixOS.programs.plymouth.mikuboot {
          themePackages = [pkgs.mikuboot];
          theme = "mikuboot";
        })
      ];

      # Enable "Silent boot"
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;
    };
  };
}
