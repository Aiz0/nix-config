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
    config = let
      authKeyFile = config.age.secrets.tailscaleAuthKey.path or null;
    in {
      assertions = [
        {
          assertion = authKeyFile != null;
          message = "Tailscale authKeyFile cannot be null.";
        }
      ];

      age.secrets.tailscaleCaddyAuth.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";

      networking.firewall = {
        allowedUDPPorts = [config.services.tailscale.port];
        trustedInterfaces = [config.services.tailscale.interfaceName];
      };

      services = {
        tailscale = {
          enable = true;
          inherit authKeyFile;

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
