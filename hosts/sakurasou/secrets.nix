{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    tailscaleCaddyAuthKey.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
    radarrApiKey.file = "${self.inputs.secrets}/arr/radarrApiKey.age";
    sonarrApiKey.file = "${self.inputs.secrets}/arr/sonarrApiKey.age";
  };
}
