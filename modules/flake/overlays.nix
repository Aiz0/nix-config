{self, ...}: {
  flake.overlays = {
    default = _final: prev: {
      inherit (self.inputs.oculante-fix.legacyPackages.${prev.system}) oculante;
    };
  };
}
