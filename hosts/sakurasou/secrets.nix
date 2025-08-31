{self, ...}: {
  age.secrets = {
    tailscaleAuthKey.file = "${self.inputs.secrets}/tailscale/auth.age";
    tailscaleCaddyAuthKey.file = "${self.inputs.secrets}/tailscale/caddyAuth.age";
    radarrApiKey.file = "${self.inputs.secrets}/arr/radarrApiKey.age";
    sonarrApiKey.file = "${self.inputs.secrets}/arr/sonarrApiKey.age";
    kavitaTokenKey.file = "${self.inputs.secrets}/kavita/tokenKey.age";
    # TODO: move to home or git module when i figure out how to make it work;
    gitWorkConfig = {
      file = "${self.inputs.secrets}/git/workConfig.age";
      path = "/home/aiz/local/config/git/workConfig";
      mode = "777";
      owner = "aiz";
    };
  };
}
