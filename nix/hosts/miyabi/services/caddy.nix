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
          hash = "sha256-JxsaP12OBPLCDv1JLSuiuikpUSB30nmY51sBAq8v8BE=";
        };
      };

      tailscale.permitCertUid = "caddy";
    };
  };
}
