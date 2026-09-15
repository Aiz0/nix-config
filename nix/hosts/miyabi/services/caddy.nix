_: {
  flake.nixosModules.miyabi = {
    config,
    pkgs,
    self,
    ...
  }: {
    sops.secrets.tailscaleCaddyAuthEnv = {
      sopsFile = self + "/secrets/tailscaleCaddy.env";
      format = "dotenv";
    };
    networking.firewall.allowedTCPPorts = [80 443];

    services = {
      caddy = {
        enable = true;
        enableReload = false;
        environmentFile = config.sops.secrets.tailscaleCaddyAuthEnv.path;

        globalConfig = ''
          tailscale {
            ephemeral true
          }
        '';

        package = pkgs.caddy.withPlugins {
          plugins = ["github.com/tailscale/caddy-tailscale@v0.0.0-20250508175905-642f61fea3cc"];
          hash = "sha256-ab0EDO5DmpDF5GGg2bsGf/yLacjxhr/lISl0yu+w8GM=";
        };
      };

      tailscale.permitCertUid = "caddy";
    };
  };
}
