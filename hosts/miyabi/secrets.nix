{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    tailscaleCaddyAuthKey.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
    bazarrApiKey.file = "${self.inputs.secrets}/bazarr/tokenKey.age";
    lidarrApiKey.file = "${self.inputs.secrets}/lidarr/tokenKey.age";
    prowlarrApiKey.file = "${self.inputs.secrets}/prowlarr/tokenKey.age";
    radarrApiKey.file = "${self.inputs.secrets}/arr/radarrApiKey.age";
    sonarrApiKey.file = "${self.inputs.secrets}/arr/sonarrApiKey.age";
    kavitaTokenKey.file = "${self.inputs.secrets}/kavita/tokenKey.age";
  };
}
