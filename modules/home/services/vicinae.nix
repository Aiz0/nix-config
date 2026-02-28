{
  config,
  lib,
  self,
  pkgs,
  ...
}: {
  imports = [
    self.inputs.vicinae.homeManagerModules.default
  ];
  options.myHome.services.vicinae.enable = lib.mkEnableOption "Vicinae raycast inspired launcher";

  config = lib.mkIf config.myHome.services.vicinae.enable {
    services.vicinae = {
      enable = true;
      settings = {
        close_on_focus_loss = true;
        # Display above fullscreen windows in niri
        launcher_window.layer_shell.layer = "overlay";
      };
      extensions = with self.inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        fuzzy-files
        it-tools
        niri
        nix
        process-manager
      ];
      systemd = {
        enable = true;
        autoStart = true; # default: false
        environment = {
          USE_LAYER_SHELL = 1;
        };
      };
    };
  };
}
