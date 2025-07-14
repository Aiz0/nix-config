{self, ...}: {
  imports = [
    self.inputs.zen-browser.homeModules.beta
  ];
  programs.zen-browser.enable = true;
}
