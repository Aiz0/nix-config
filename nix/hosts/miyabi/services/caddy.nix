_: {
  flake.nixosModules.miyabi = {
    config,
    pkgs,
    self,
    ...
  }: {
    age.secrets.tailscaleCaddyAuth.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
    networking.firewall.allowedTCPPorts = [80 443];

    services = {
      caddy = {
        enable = true;
        enableReload = false;
        environmentFile = config.age.secrets.tailscaleCaddyAuth.path;

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
