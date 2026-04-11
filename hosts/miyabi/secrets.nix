{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    tailscaleCaddyAuthKey.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
    bazarrApiKey.file = "${self.inputs.secrets}/arr/bazarrApiKey.age";
    lidarrApiKey.file = "${self.inputs.secrets}/arr/lidarrApiKey.age";
    prowlarrApiKey.file = "${self.inputs.secrets}/arr/prowlarrApiKey.age";
    radarrApiKey.file = "${self.inputs.secrets}/arr/radarrApiKey.age";
    sonarrApiKey.file = "${self.inputs.secrets}/arr/sonarrApiKey.age";
    slskdEnv.file = "${self.inputs.secrets}/slskd/environment.age";
    kavitaTokenKey.file = "${self.inputs.secrets}/kavita/tokenKey.age";
    komfEnv.file = "${self.inputs.secrets}/komf/environment.age";
    grafanaSecretKey = {
      file = "${self.inputs.secrets}/grafana/secretKey.age";
      owner = "grafana";
    };
    multiScrobblerEnv.file = "${self.inputs.secrets}/multiScrobbler/environment.age";
  };
}
