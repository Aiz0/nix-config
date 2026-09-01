_: {
  flake.homeModules.aizDesktop = {
    self,
    pkgs,
    ...
  }: {
    imports = [
      self.inputs.vicinae.homeManagerModules.default
    ];

    programs.vicinae = {
      enable = true;
      settings = {
        close_on_focus_loss = true;
        # Display above fullscreen windows in niri
        launcher_window.layer_shell.layer = "overlay";
      };
      extensions = with self.inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        #bluetooth # currently broken
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
