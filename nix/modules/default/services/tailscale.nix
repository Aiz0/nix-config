_: {
  flake.nixosModules.default = {
    config,
    lib,
    self,
    ...
  }: {
    options.myNixOS.services.tailscale = {
      operator = lib.mkOption {
        description = "Tailscale operator name";
        default = null;
        type = lib.types.nullOr lib.types.str;
      };
    };
    config = {
      networking.firewall = {
        allowedUDPPorts = [config.services.tailscale.port];
        trustedInterfaces = [config.services.tailscale.interfaceName];
      };

      sops.secrets.tailscale-auth-key.sopsFile = self + "/secrets/tailscale.yaml";
      services = {
        tailscale = {
          enable = true;
          authKeyFile = config.sops.secrets.tailscale-auth-key.path;

          extraUpFlags =
            ["--ssh"]
            ++ lib.optional (config.myNixOS.services.tailscale.operator != null)
            "--operator=${config.myNixOS.services.tailscale.operator}";

          openFirewall = true;
          permitCertUid = lib.mkIf config.services.caddy.enable "caddy";
          useRoutingFeatures = "both";
        };
      };
    };
  };
}
