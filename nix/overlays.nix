_: {
  flake.overlays = {
    default = _final: prev: {
      # https://github.com/NixOS/nixpkgs/issues/575192

      aggregateModules = modules:
        (prev.aggregateModules modules).overrideAttrs (_old: {
          ignoreCollisions = true;
        });

      linuxPackages_latest = prev.linuxPackages_latest.extend (lps: old: {
        zenpower = old.zenpower.overrideAttrs (pkg: {
          makeFlags = (pkg.makeFlags or []) ++ old.kernelModuleMakeFlags;

          installPhase = ''
            runHook preInstall

            make -C "${lps.kernel.dev}/lib/modules/${lps.kernel.modDirVersion}/build" \
              M="$PWD" INSTALL_MOD_PATH="$out" DEPMOD=true modules_install \
              ${prev.lib.escapeShellArgs old.kernelModuleMakeFlags}

            runHook postInstall
          '';
        });
      });
    };
  };
}
