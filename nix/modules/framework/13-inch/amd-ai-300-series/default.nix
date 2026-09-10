_: {
  flake.nixosModules.framework-laptop13-amd-ai-300 = {
    boot = {
      initrd.availableKernelModules = ["nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci"];

      extraModprobeConfig = ''
        options snd_hda_intel power_save=1
      '';
    };

    networking.networkmanager = {
      enable = true;

      wifi = {
        backend = "iwd";
        powersave = true;
      };
    };
  };
}
